provider "google" {
  project = "fpa-dev-1"
}

module "service-accounts" {
  source          = "../modules/service_account"
  project_id      = var.project_id
  project_number  = var.project_number
}

# Create VPC Network
module "vpc_network" {
    source                  = "../modules/network"
    project_id              = var.project_id
    region                  = var.region
    env                     = var.env
    primary-subnet-range    = var.primary-subnet-range
}

# Create Cloud NAT to allow services to connect to MongoDB Cloud
module "cloud_nat" {
    source                  = "../modules/cloud_nat"
    project_id              = var.project_id
    env                     = var.env
    vpc_network_name        = module.vpc_network.network_name
    region                  = var.region
}

module "login-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-login-service"
  region          = var.region
  env             = var.env
  service_port    = "26001"
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

module "asset-management-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-asset-management-service"
  region          = var.region
  env             = var.env
  service_port    = "26051"
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

module "liability-management-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-liability-management-service"
  region          = var.region
  env             = var.env
  service_port    = "26052"
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

module "expense-management-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-expense-management-service"
  region          = var.region
  env             = var.env
  service_port    = "26053"
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

module "income-management-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-income-management-service"
  region          = var.region
  env             = var.env
  service_port    = "26054"
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

module "ui-service" {
  source          = "../modules/fpa_frontend_services"
  service_name    = "fpa-ui-service"
  region          = var.region
  env             = var.env
  service_port    = "80"
  service_account = module.service-accounts.cloud_run_sa_email
  login_api       = "${module.login-service.uri}/login"
  asset_mgmt_api  = "${module.asset-management-service.uri}/finmgmt/assets"
  liability_mgmt_api  = "${module.liability-management-service.uri}/finmgmt/liabilities"
  expense_mgmt_api  = "${module.expense-management-service.uri}/finmgmt/expenses"
  income_mgmt_api  = "${module.income-management-service.uri}/finmgmt/incomes"
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

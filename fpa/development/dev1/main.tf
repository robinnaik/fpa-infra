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

module "backend-services" {
  for_each = var.services
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-${each.key}-service"
  region          = var.region
  env             = var.env
  service_port    = each.value.port
  service_account = module.service-accounts.cloud_run_sa_email
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

# network and subnet required for internal communication
module "ui-service" {
  source          = "../modules/fpa_frontend_services"
  service_name    = "fpa-ui-service"
  region          = var.region
  env             = var.env
  service_port    = "80"
  service_account = module.service-accounts.cloud_run_sa_email
  login_api       = "${module.backend-services["login"].uri}/login"
  asset_mgmt_api  = "${module.backend-services["asset-management"].uri}/finmgmt/assets"
  liability_mgmt_api  = "${module.backend-services["liability-management"].uri}/finmgmt/liabilities"
  expense_mgmt_api  = "${module.backend-services["expense-management"].uri}/finmgmt/expenses"
  income_mgmt_api  = "${module.backend-services["income-management"].uri}/finmgmt/incomes"
  network         = module.vpc_network.network_name
  subnet          = module.vpc_network.subnet1_name
}

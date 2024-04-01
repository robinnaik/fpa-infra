provider "google" {
  project = "fpa-dev-1"
}

module "service-accounts" {
  source          = "../modules/service_account"
  project_id      = var.project_id
  project_number  = var.project_number
}

module "login-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-login-service"
  region          = var.region
  env             = var.env
  service_port    = "26001"
  service_account = module.service-accounts.cloud_run_sa_email
}

module "asset-management-service" {
  project_number  = var.project_number
  source          = "../modules/fpa_backend_services"
  service_name    = "fpa-asset-management-service"
  region          = var.region
  env             = var.env
  service_port    = "26051"
  service_account = module.service-accounts.cloud_run_sa_email
}

module "ui-service" {
  source          = "../modules/fpa_frontend_services"
  service_name    = "fpa-ui-service"
  region          = var.region
  env             = var.env
  service_port    = "80"
  service_account = module.service-accounts.cloud_run_sa_email
  login_api       = module.login-service.uri
}

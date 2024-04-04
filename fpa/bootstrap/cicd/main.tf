provider "google" {
  project = "fpa-b-cicd"
}

module "build-common" {
  for_each                = toset(var.services)
  source                  = "./modules/trigger"
  region                  = var.build_region
  service                 = each.value
}
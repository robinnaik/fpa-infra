resource "google_compute_address" "internal_address" {
  name         = var.name
  subnetwork   = var.vpc_subnet_name
  address_type = "INTERNAL"
  address      = var.address
  region       = var.region
}
resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "${var.project_id}-subnet1"
  ip_cidr_range = var.primary-subnet-range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}




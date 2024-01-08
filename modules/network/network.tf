resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-${var.env}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "${var.project_id}-${var.env}-subnet1"
  ip_cidr_range = var.primary-subnet-range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "${var.project_id}-${var.env}-cluster-ips"
    ip_cidr_range = var.secondary-cluster-ips
  }
  secondary_ip_range {
    range_name    = "${var.project_id}-${var.env}-service-ips"
    ip_cidr_range = var.secondary-service-ips
  }
}




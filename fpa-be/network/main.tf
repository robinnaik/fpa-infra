provider "google" {
  project = var.project_id
  region  = var.region
}

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
    range_name    = "${var.project_id}-${var.env}-secondary-range1"
    ip_cidr_range = var.secondary-range-1
  }
  secondary_ip_range {
    range_name    = "${var.project_id}-${var.env}-secondary-range2"
    ip_cidr_range = var.secondary-range-2
  }
}

resource "google_compute_firewall" "icmp" {
  name    = "${var.project_id}-${var.env}-allow-icmp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }
  
  source_ranges = [
    var.primary-subnet-range
  ]
  
}

resource "google_compute_firewall" "tcp" {
  name    = "${var.project_id}-${var.env}-allow-tcp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22","8080","80"]
  }
  
  source_ranges = [
    var.primary-subnet-range
  ] 
}

resource "google_compute_network_peering" "vpc_peering" {
  name         = "${var.project_id}-to-${var.peer_project}-peering"
  network      = google_compute_network.vpc_network.self_link
  peer_network = "projects/${var.peer_project}/global/networks/${var.peer_project}-${var.env}-network"
}

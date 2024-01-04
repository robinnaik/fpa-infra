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
    range_name    = "${var.project_id}-${var.env}-cluster-ips"
    ip_cidr_range = var.secondary-cluster-ips
  }
  secondary_ip_range {
    range_name    = "${var.project_id}-${var.env}-service-ips"
    ip_cidr_range = var.secondary-service-ips
  }
}

resource "google_compute_subnetwork" "vpc_subnet_proxy_only" {
  name          = "${var.project_id}-${var.env}-proxy-only"
  ip_cidr_range = var.proxy-only-subnet-range
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  region        = var.region
  network       = google_compute_network.vpc_network.id
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
    ports = ["80","8080"]
  }
  
  source_ranges = [
    var.primary-subnet-range,
    var.peer-subnet-range
  ] 
}

resource "google_compute_network_peering" "vpc_peering" {
  name         = "${var.project_id}-to-${var.peer_project}-peering"
  network      = google_compute_network.vpc_network.self_link
  peer_network = "projects/${var.peer_project}/global/networks/${var.peer_project}-${var.env}-network"
}

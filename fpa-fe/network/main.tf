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

#TODO: To be removed once backend loadbalancer work with internal-gce
resource "google_compute_router" "nat-router" {
  name    = "my-router"
  region  = var.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

#TODO: To be removed once backend loadbalancer work with internal-gce
resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_id}-${var.env}-nat"
  router                             = google_compute_router.nat-router.name
  region                             = google_compute_router.nat-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
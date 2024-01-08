#TODO: To be removed once backend loadbalancer work with internal-gce
resource "google_compute_router" "nat-router" {
  name    = "my-router"
  region  = var.region
  network = var.vpc_network_name

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
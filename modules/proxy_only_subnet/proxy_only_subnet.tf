resource "google_compute_subnetwork" "proxy_only_subnet" {
  name          = "${var.project_id}-${var.env}-proxy-only"
  ip_cidr_range = var.proxy_only_subnet_range
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  region        = var.region
  network       = var.vpc_network_id
}
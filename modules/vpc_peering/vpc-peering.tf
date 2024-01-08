resource "google_compute_network_peering" "vpc_peering" {
  name         = "${var.project_id}-to-${var.peer_project}-peering"
  network      = var.vpc_network_id
  peer_network = var.vpc_peer_network_id
}
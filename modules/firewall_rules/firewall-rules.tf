resource "google_compute_firewall" "allow-icmp" {
  name    = "${var.project_id}-${var.env}-allow-icmp"
  network = var.vpc_network_name

  allow {
    protocol = "icmp"
  } 

  source_ranges = var.icmp_source_ranges
}

resource "google_compute_firewall" "allow-tcp" {
  name    = "${var.project_id}-${var.env}-allow-tcp"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports = var.tcp_ports
  }
  source_ranges = var.tcp_source_ranges

}
output "network_name" {
  description = "Name of the network"
  value = google_compute_network.vpc_network.name
}

output "network_id" {
  description = "Name of the network"
  value = google_compute_network.vpc_network.id
}
output "network_name" {
  description = "Name of the network"
  value = google_compute_network.vpc_network.name
}

output "network_id" {
  description = "Name of the network"
  value = google_compute_network.vpc_network.id
}

output "subnet1_name" {
  description = "First regional subnet"
  value = google_compute_subnetwork.vpc_subnet.name
}

output "secondary-cluster-ips" {
  description = "First secondary range for first subnet"
  value = google_compute_subnetwork.vpc_subnet.secondary_ip_range[0].range_name
}


output "secondary-service-ips" {
  description = "First secondary range for second subnet"
  value = google_compute_subnetwork.vpc_subnet.secondary_ip_range[1].range_name
}
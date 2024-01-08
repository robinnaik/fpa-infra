variable "project_id" {
  description = "The project ID to host the cluster in"
  type = string
}

variable "vpc_network_id" {
  description = "Name of the VPC network"
  type = string
}

variable "peer_project" {
  description = "Peer network"
  type = string
}

variable "vpc_peer_network_id" {
  description = "Name of the Peer VPC network"
  type = string
}


variable "project_id" {
  description = "The project ID to host the cluster in"
  type = string
}

variable "env" {
  description = "The name for the GKE cluster"
  type = string
}

variable "region" {
  description = "Region for the cluster"
  type = string
}

variable "primary-subnet-range" {
  description = "Primary Subet Range"
  type = string
}

variable "secondary-cluster-ips" {
  description = "Secondary Range to be used for Cluster IPs"
  type = string
}

variable "secondary-service-ips" {
  description = "Secondary Range to be used by Services"
  type = string
}

variable "peer_project" {
  description = "Peer network"
  type = string
}
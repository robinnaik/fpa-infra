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

variable "vpc_network_name" {
  description = "Name of the VPC network"
  type = string
}
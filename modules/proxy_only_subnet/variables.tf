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

variable "vpc_network_id" {
  description = "ID of the VPC network to which firewall rule is applied"
  type = string
}

variable "proxy_only_subnet_range" {
  description = "Range for proxy only subnet"
  type = string
}
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

variable "vpc_subnet_name" {
  description = "Name of the VPC subnet network"
  type = string
}

variable "cluster_control_plan_cidr" {
  description = "CIDR block for cluster control plane"
  type = string
}

variable "cluster_ip_range" {
  description = "Cluster IP Range"
  type = string
}

variable "service_ip_range" {
  description = "Service IP Range"
  type = string
}

variable "app_stack" {
  description = "Type of app to be deployed"
  type = string
}
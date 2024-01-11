variable "vpc_subnet_name" {
  description = "Name of the VPC subnet network"
  type = string
}

variable "name" {
  description = "Name of the address"
  type = string
}

variable "address" {
  description = "IP Address to be reserved"
  type = string
}

variable "region" {
  description = "Region for the cluster"
  type = string
}
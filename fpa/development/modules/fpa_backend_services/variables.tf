variable "project_number" {
  description = "The project number"
  type = string
}

variable "service_name" {
  description = "Name of Google Cloud Run Service"
  type = string
}

variable "service_port" {
  description = "Port on which the service is exposed"
  type = string
}

variable "service_account" {
  description = "Service account used by cloud run service"
  type = string
}

variable "env" {
  description = "The name for the GKE cloud run"
  type = string
}

variable "region" {
  description = "Region for the cloud run"
  type = string
}

variable "network" {
  description = "Network for the cloud run"
  type = string
}

variable "subnet" {
  description = "Subnet for the cloud run"
  type = string
}
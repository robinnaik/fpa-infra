variable "project_id" {
  description = "The project ID to host the cloud run in"
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

variable "primary-subnet-range" {
  description = "Primary Subet Range"
  type = string
}
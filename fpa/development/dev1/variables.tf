variable "project_id" {
  description = "The project ID"
  default = "fpa-dev-1"
}

variable "project_number" {
  description = "The project number"
  default = "606010765839"
}

variable "env" {
  description = "The name for the GKE cloud run"
  default     = "dev-1"
}

variable "region" {
  description = "Region for the cloud run"
  default = "asia-south1"
}

variable "primary-subnet-range" {
  description = "Region for the cloud run"
  default = "10.160.0.0/16"
}

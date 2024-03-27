variable "service" {
  description = "Service Name e.g. common, asset-management etc"
  type = string
}

variable "service_account" {
  description = "Service Account to build"
  type = string
}

variable "region" {
  description = "Region for the cluster"
  type = string
}

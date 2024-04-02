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
  description = "The name for the GKE cluster"
  type = string
}

variable "region" {
  description = "Region for the cluster"
  type = string
}

variable "login_api" {
  description = "Login API"
  type = string
}

variable "asset_mgmt_api" {
  description = "Asset Management API"
  type = string
}

variable "liability_mgmt_api" {
  description = "Liability Management API"
  type = string
}

variable "expense_mgmt_api" {
  description = "Expense Management API"
  type = string
}

variable "income_mgmt_api" {
  description = "Income Management API"
  type = string
}
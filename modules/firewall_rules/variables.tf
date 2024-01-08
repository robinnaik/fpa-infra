variable "project_id" {
  description = "The project ID to host the cluster in"
  type = string
}

variable "env" {
  description = "The name for the GKE cluster"
  type = string
}

variable "vpc_network_name" {
  description = "Name of the VPC network to which firewall rule is applied"
  type = string
}


variable "tcp_source_ranges" {
  description = "Source ranges for ICMP allow firewall rule"
  type = list(string)
}

variable "icmp_source_ranges" {
  description = "Source ranges for TCP allow firewall rule"
  type = list(string)
}

variable "tcp_ports" {
  description = "TCP ports for TCP allow firewall rule"
  type = list(string)
}
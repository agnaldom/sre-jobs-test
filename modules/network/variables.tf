
# -------------------------------------------------------------
# Network variables
# -------------------------------------------------------------

variable "vpc_cidr" {
  description = "The CIDR range for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "True if the DNS support is enabled in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "True if DNS hostnames is enabled in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "The type of tenancy for EC2 instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string

}

# -------------------------------------------------------------
# Tagging
# -------------------------------------------------------------

variable "tags" {
  description = "A map of tags for the VPC resources"
  type        = map(string)
  default     = {}
}

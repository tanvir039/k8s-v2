variable "region" {
  description = "AWS region for this environment"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Short project name used to prefix resource names/tags"
  type        = string
  default     = "eks-v2-project"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# variable "azs" {
#   description = "Availability Zones to spread subnets/nodes across"
#   type        = list(string)
#   default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
# }

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets, one per AZ, same order as var.azs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
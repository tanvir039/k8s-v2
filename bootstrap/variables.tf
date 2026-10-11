variable "region" {
  description = "AWS region for the Terraform state bucket"
  type        = string
  default     = "eu-west-2"
}

variable "state_bucket_name" {
  description = "Globally-unique S3 bucket name for Terraform remote state"
  type        = string
}

variable "tags" {
  description = "Common tags applied to bootstrap resources"
  type        = map(string)
  default = {
    Project   = "eks-v2-project"
    Owner     = "tanvir"
  }
}
variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
  default     = "ercli-cep3-cluster"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "123.45.0.0/16"
}

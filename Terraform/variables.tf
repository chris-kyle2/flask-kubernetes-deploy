variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}
variable "cluster_name" {
  default     = "100ms-eks-cluster"
  description = "eks cluster name"
}

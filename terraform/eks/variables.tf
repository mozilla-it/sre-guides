variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-west-2"
}

variable "cluster_version" {
  default = "1.12"
}

variable "lifecycled_version" {
  default = "v3.0.2"
}

variable "prefix" {
  default = "k8s"
}

variable "lifecycled_log_group" {
  default = "/aws/lifecycled"
}


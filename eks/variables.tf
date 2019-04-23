variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-west-2"
}

variable "cluster_version" {
  default = "1.12"
}

variable "vpc_id" {}

variable "available_amis" {
  type = "map"
}

variable "subnets" {
  type    = "list"
  default = []
}

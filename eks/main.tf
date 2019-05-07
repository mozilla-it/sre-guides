#---
# EKS cluster
# Note: https://thinklumo.com/blue-green-node-deployment-kubernetes-eks-terraform/
#---

terraform {
  backend "s3" {
    bucket = "terramoz-eks-state"
    key    = "us-east-1/afrank-0/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  cluster_name = "kubernetes-${var.environment}-${var.region}"

  worker_groups = [
    {
      name                  = "k8s-worker-green"
      ami_id                = "${lookup(var.available_amis,var.region)}"
      asg_desired_capacity  = "6"
      asg_max_size          = "10"
      asg_min_size          = "3"
      asg_force_delete      = true
      autoscaling_enabled   = true
      protect_from_scale_in = false
      instance_type         = "m4.large"
      root_volume_size      = "100"
      subnets               = "${join(",",var.subnets)}"
      additional_userdata   = "${data.template_file.additional_userdata.rendered}"
    },
    {
      name                  = "k8s-worker-blue"
      ami_id                = "${lookup(var.available_amis,var.region)}"
      asg_desired_capacity  = "0"
      asg_max_size          = "0"
      asg_min_size          = "0"
      autoscaling_enabled   = true
      protect_from_scale_in = false
      asg_force_delete      = true
      instance_type         = "m4.large"
      root_volume_size      = "100"
      subnets               = "${join(",",var.subnets)}"
      additional_userdata   = "${data.template_file.additional_userdata.rendered}"
    },
  ]

  tags = {
    "Region"      = "${var.region}"
    "Environment" = "${var.environment}"
    "Terraform"   = "true"
  }
}

data "template_file" "additional_userdata" {
  template = "${file("${path.module}/userdata/additional-userdata.sh")}"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "3.0.0"

  cluster_name       = "${local.cluster_name}"
  cluster_version    = "${var.cluster_version}"
  subnets            = "${var.subnets}"
  vpc_id             = "${var.vpc_id}"
  worker_groups      = "${local.worker_groups}"
  worker_group_count = "2"
  tags               = "${local.tags}"
  write_kubeconfig   = "true"
  manage_aws_auth    = "true"                   # You will need aws-iam-authenticator and kubectl installed for this
}

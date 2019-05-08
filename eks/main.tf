locals {
  cluster_name = "k8s-${var.environment}-${var.region}"

  worker_groups = [
    {
      asg_desired_capacity  = "6"
      asg_max_size          = "10"
      asg_min_size          = "3"
      asg_force_delete      = true
      autoscaling_enabled   = true
      protect_from_scale_in = false
      instance_type         = "m4.large"
      root_volume_size      = "100"
      spot_price            = "0.04"
      subnets               = "${join(",", data.terraform_remote_state.deploy.private_subnets)}"
      additional_userdata   = "${data.template_file.additional_userdata.rendered}"
      kubelet_extra_args    = "--node-labels=kubernetes.io/lifecycle=spot"
    },
  ]

  # Change this as needed
  map_roles = [
    {
      username = "itsre-admin"
      role_arn = "arn:aws:iam::517826968395:role/itsre-admin"
      group    = "system:masters"
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

  vars = {
    lifecycled_version = "${var.lifecycled_version}"
    region             = "${var.region}"
    sns_topic          = "${aws_sns_topic.main.arn}"
    cluster_name       = "${module.eks.cluster_id}"
    log_group_name     = "${var.lifecycled_log_group}"
  }
}

# Allow SSM access
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = "${module.eks.worker_iam_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "4.0.2"

  cluster_name    = "${local.cluster_name}"
  cluster_version = "${var.cluster_version}"

  vpc_id                = "${data.terraform_remote_state.deploy.vpc_id}"
  subnets               = ["${data.terraform_remote_state.deploy.public_subnets}"]
  worker_groups         = "${local.worker_groups}"
  worker_group_count    = "${length(worker_groups)}"
  tags                  = "${local.tags}"
  map_roles             = "${local.map_roles}"
  map_roles_count       = "${length(local.map_roles)}"
  kubeconfig_name       = "${local.cluster_name}"
  write_kubeconfig      = "false"
  write_aws_auth_config = "false"
  manage_aws_auth       = "true"                                                   # You will need aws-iam-authenticator and kubectl installed for this
}

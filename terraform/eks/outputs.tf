output "cluster_name" {
  value = "${module.eks.cluster_id}"
}

output "worker_iam_role_arn" {
  value = "${module.eks.worker_iam_role_arn}"
}

output "worker_security_group_id" {
  value = "${module.eks.worker_security_group_id}"
}

output "worker_asg_name" {
  value = "${module.eks.workers_asg_names}"
}

output "public_subnets" {
  value = "${data.terraform_remote_state.deploy.public_subnets}"
}

output "private_subnets" {
  value = "${data.terraform_remote_state.deploy.private_subnets}"
}

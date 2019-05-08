data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# This assume your vpc_id output is called vpc_id
data "aws_vpc" "this" {
  id = "${data.terraform_remote_state.deploy.vpc_id}"
}

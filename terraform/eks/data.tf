# This assume your vpc_id output is called vpc_id
data "aws_vpc" "this" {
  id = data.terraform_remote_state.deploy.outputs.vpc_id
}


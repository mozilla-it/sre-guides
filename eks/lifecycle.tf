resource "aws_autoscaling_lifecycle_hook" "lifecycle_hook" {
  count                   = "${length(module.eks.workers_asg_names)}"
  name                    = "${local.cluster_name}-termination-hook-${count.index}"
  autoscaling_group_name  = "${element(module.eks.workers_asg_names, count.index)}"
  default_result          = "CONTINUE"
  heartbeat_timeout       = "60"
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${aws_sns_topic.main.arn}"
  role_arn                = "${aws_iam_role.lifecycle_hook.arn}"
}

resource "aws_sns_topic" "main" {
  name = "${local.cluster_name}-asg-termination"
}

resource "aws_cloudwatch_log_group" "lifecycled" {
  name = "${var.lifecycled_log_group}"

  tags = {
    Region    = "${var.region}"
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "asg_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["autoscaling.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "asg_permissions" {
  statement {
    effect = "Allow"

    resources = [
      "${aws_sns_topic.main.arn}",
    ]

    actions = [
      "sns:Publish",
    ]
  }
}

data "aws_iam_policy_document" "worker_permissions" {
  statement {
    effect = "Allow"

    actions = [
      "sns:Subscribe",
      "sns:Unsubscribe",
    ]

    resources = [
      "${aws_sns_topic.main.arn}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:lifecycled-*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "autoscaling:RecordLifecycleActionHeartbeat",
      "autoscaling:CompleteLifecycleAction",
    ]

    resources = ["arn:aws:autoscaling:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:autoScalingGroup:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.lifecycled.arn}",
    ]
  }
}

resource "aws_iam_role" "lifecycle_hook" {
  name               = "${local.cluster_name}-lifecycle-role"
  assume_role_policy = "${data.aws_iam_policy_document.asg_assume.json}"
}

resource "aws_iam_role_policy" "lifecycle_hook" {
  name   = "${local.cluster_name}-lifecycle-asg-permissions"
  role   = "${aws_iam_role.lifecycle_hook.id}"
  policy = "${data.aws_iam_policy_document.asg_permissions.json}"
}

resource "aws_iam_role_policy" "worker_permission" {
  name   = "${local.cluster_name}-lifecycle-worker-permissions"
  role   = "${module.eks.worker_iam_role_name}"
  policy = "${data.aws_iam_policy_document.worker_permissions.json}"
}

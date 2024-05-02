locals {
  do_logging     = var.log_group_name != null && var.log_group_name != ""
  log_group_name = local.do_logging ? var.log_group_name : null
}

data "aws_cloudwatch_log_group" "this" {
  count = length(compact([local.log_group_name]))

  name = var.create_log_group ? aws_cloudwatch_log_group.this["ad_logs"].name : local.log_group_name
}

resource "aws_cloudwatch_log_group" "this" {
  for_each = var.create_log_group && local.do_logging ? toset(["ad_logs"]) : toset([])

  name = var.log_group_name
  tags = local.resolved_tags
}

data "aws_iam_policy_document" "ad_log_policy" {
  for_each = local.do_logging ? toset(["ad_logs"]) : toset([])

  statement {
    sid    = "CreateStreamAndLogEvents"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${data.aws_cloudwatch_log_group.this[0].arn}:*"]
    principals {
      type        = "Service"
      identifiers = ["ds.amazonaws.com"]
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "ad_logs" {
  for_each = local.do_logging ? toset(["ad_logs"]) : toset([])

  policy_name     = "DirectoryServiceLoggingPolicy"
  policy_document = data.aws_iam_policy_document.ad_log_policy["ad_logs"].json
}

resource "aws_directory_service_log_subscription" "this" {
  for_each = local.do_logging ? toset(["ad_logs"]) : toset([])

  directory_id   = aws_directory_service_directory.this.id
  log_group_name = data.aws_cloudwatch_log_group.this[0].name
}

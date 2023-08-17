locals {
  names_arns = merge(
    { for pol in var.managed_policy_names : pol => data.aws_iam_policy.managed[pol].arn },
    { (local.policy_name) = var.policy_document != "" ? aws_iam_policy.this[local.policy_name].arn : null }
  )
  policy_name = "${local.role_name}-policy"
  policy_path = local.role_path
  policy_tags = merge(local.default_tags, { Name = local.policy_name }, var.extra_tags)
}

data "aws_iam_policy" "managed" {
  for_each = toset(var.managed_policy_names)

  name = each.value
}

resource "aws_iam_policy" "this" {
  for_each = var.policy_document != "" ? toset([local.policy_name]) : toset([])

  name        = local.policy_name
  path        = local.policy_path
  description = var.policy_description
  policy      = var.policy_document

  tags = local.policy_tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = local.names_arns

  policy_arn = each.value
  role       = aws_iam_role.this.name
}

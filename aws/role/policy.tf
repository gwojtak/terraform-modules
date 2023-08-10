locals {
  policy_name = "${local.role_name}-policy"
  policy_path = local.role_path
  policy_tags = merge(var.extra_tags, { Name = local.policy_name })
}

resource "aws_iam_policy" "this" {
  name        = local.policy_name
  path        = local.policy_path
  description = var.policy_description
  policy      = var.policy_document

  tags = local.policy_tags
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}

data "aws_iam_policy" "admin" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "boundary" {
  count = length(compact([var.permissions_boundary]))

  name = var.permissions_boundary
}

resource "aws_iam_group" "admin" {
  name = var.admin_group_name
  path = var.admin_group_path
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = aws_iam_group.admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}

resource "aws_iam_user" "admin" {
  name                 = var.admin_username
  path                 = var.admin_user_path
  permissions_boundary = var.permissions_boundary != null ? data.aws_iam_policy.boundary[0].arn : null

  tags = merge({ Name = var.admin_username }, local.default_tags)
}

resource "aws_iam_group_membership" "admins" {
  name  = "account-admin-membership"
  group = aws_iam_group.admin.name
  users = [aws_iam_user.admin.name]
}

resource "aws_iam_user_login_profile" "admin" {
  user                    = aws_iam_user.admin.name
  pgp_key                 = var.pgp_key
  password_length         = var.admin_password_length
  password_reset_required = var.require_password_change
}

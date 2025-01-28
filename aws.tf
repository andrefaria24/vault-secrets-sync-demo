# Create IAM user to be used for Vault access to AWS Secrets Manager
resource "aws_iam_user" "usr_ss_demo" {
  name = "ss-demo"

  tags = {
    tag-key = "vault secrets sync demo"
  }
}

resource "aws_iam_access_key" "usr_ss_demo" {
  user = aws_iam_user.usr_ss_demo.name
}

# Required permissions by Vault
data "aws_iam_policy_document" "pol_secrets_syncing" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:secretsmanager:*:*:secret:vault*"]

    actions = [
      "secretsmanager:Create*",
      "secretsmanager:Update*",
      "secretsmanager:Delete*",
      "secretsmanager:TagResource",
    ]
  }
}

resource "aws_iam_user_policy" "usr_ss_demo" {
  name   = "secrets_syncing"
  user   = aws_iam_user.usr_ss_demo.name
  policy = data.aws_iam_policy_document.pol_secrets_syncing.json
}
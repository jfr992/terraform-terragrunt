data "aws_region" "current" {}

data "aws_iam_policy" "SSM" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
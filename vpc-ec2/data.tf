data "template_file" "userdata" {
  template = file("./files/userdata.sh")
}

data "aws_region" "current" {}

data "aws_iam_policy" "SSM" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
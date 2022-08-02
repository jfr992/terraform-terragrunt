resource "aws_dynamodb_table" "terraform-lock" {
  name           = "${var.tf-state-bucket-name}-terraform-lock"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

}


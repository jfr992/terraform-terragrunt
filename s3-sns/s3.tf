resource "aws_s3_bucket" "s3" {
  bucket = var.bucket-name
  acl    = "private"
  policy = data.aws_iam_policy_document.allow_access.json

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
#private bucket
resource "aws_s3_bucket_public_access_block" "s3_block" {
  bucket                  = aws_s3_bucket.s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${var.bucket-name}",
      "arn:aws:s3:::${var.bucket-name}/*",
    ]

  }
}

resource "aws_s3_bucket_object" "object" {
  depends_on = [
    aws_s3_bucket.s3
  ]
  bucket = var.bucket-name
  key    = "hello_world"
  source = "files/hello_world.txt"

}
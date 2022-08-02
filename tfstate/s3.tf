resource "aws_s3_bucket" "terraform-state" {
  bucket        = "${var.tf-state-bucket-name}"
  force_destroy = false
  policy        = data.aws_iam_policy_document.tfstate_s3_bucket_policy.json

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

data "aws_iam_policy_document" "tfstate_s3_bucket_policy" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${var.tf-state-bucket-name}",
      "arn:aws:s3:::${var.tf-state-bucket-name}/*",
    ]

  }
}

resource "aws_s3_bucket_public_access_block" "s3_block" {
  bucket                  = aws_s3_bucket.terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
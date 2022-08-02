resource "aws_sns_topic" "topic" {
  name = "s3-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": "*" ,
        "Action": "sns:Publish",
        "Resource": "arn:aws:sns:*:*:s3-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3.arn}"}
        }
    }]
}
POLICY
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  depends_on = [aws_sns_topic.topic]
  bucket     = aws_s3_bucket.s3.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".txt"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.email
}
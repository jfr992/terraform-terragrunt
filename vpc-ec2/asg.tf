resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "asg-webserver"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.asg_desired_capacity
  force_delete              = true
  launch_configuration      = aws_launch_configuration.lg_webserver.name
  vpc_zone_identifier       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  target_group_arns         = [aws_lb_target_group.tg.arn]

}

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_launch_configuration" "lg_webserver" {
  name          = "lg-webserver"
  image_id      = data.aws_ami.amazon-2.id
  instance_type = var.instance_type
  user_data     = base64encode(data.template_file.userdata.rendered)
  security_groups = [aws_security_group.ec2_in_80.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.SSM.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_security_group" "ec2_in_80" {

  name        = "sg ec2"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups  = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
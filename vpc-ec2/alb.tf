resource "aws_lb" "alb" {
  name            = "alb-webserver"
  internal        = true
  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "tg-webserver"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  deregistration_delay = "10"

  health_check {
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = "5"
    timeout             = "3"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    matcher             = "200"
  }

}

resource "aws_security_group" "alb" {

  name        = "sg alb"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks  = var.alb_allowed_ingress_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
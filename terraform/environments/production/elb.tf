// ELB定義

resource "aws_lb" "n8n" {
  name               = var.service_name
  load_balancer_type = "application"
  internal           = false
  subnets            = var.subnets
  security_groups = [
    aws_security_group.elb.id
  ]
}

resource "aws_lb_listener" "n8n" {
  load_balancer_arn = aws_lb.n8n.id
  port              = var.n8n_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener_rule" "n8n" {
  listener_arn = aws_lb_listener.n8n.arn

  priority = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.n8n.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_target_group" "n8n" {
  vpc_id      = var.vpc_id
  name        = var.service_name
  port        = var.n8n_port
  protocol    = "HTTP"
  target_type = "ip"

  depends_on = [
    aws_lb.n8n
  ]
}

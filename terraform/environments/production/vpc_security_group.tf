// セキュリティグループ定義

resource "aws_security_group" "elb" {
  name        = "elb"
  description = "n8n elb security group"

  ingress {
    description = "n8n request"
    from_port   = var.n8n_port
    to_port     = var.n8n_port
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    description = "outbound"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "n8n" {
  name        = "n8n"
  description = "n8n security group"

  ingress {
    description = "n8n request from elb"
    from_port   = var.n8n_port
    to_port     = var.n8n_port
    protocol    = "tcp"
    security_groups = [
      aws_security_group.elb.id
    ]
  }

  egress {
    description = "outbound"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

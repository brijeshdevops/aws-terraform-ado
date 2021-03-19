resource "aws_security_group" "es" {
  name = "${local.common_prefix}-commonuse-sg"
  description = "Security group for Common Use"
  vpc_id = aws_vpc.demo.id

  ingress {
      description = "VPC Access"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
          aws_vpc.demo.cidr_block
      ]
  }

  ingress {
      description = "Home-VPN"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["104.190.188.27/32"]
  }

  ingress {
      description = "Default Self Access"
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = "true"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
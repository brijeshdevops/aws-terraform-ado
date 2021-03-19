resource "aws_security_group" "es" {
  name = "${local.common_prefix}-commonuse-sg"
  description = "Security group for Common Use"
  vpc_id = aws_vpc.demo.id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
          aws_vpc.demo.cidr_block
      ]
  }
}
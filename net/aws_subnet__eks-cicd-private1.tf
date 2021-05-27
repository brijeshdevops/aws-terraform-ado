# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_subnet.subnet-00cc72ac5b0b79dd4:
resource "aws_subnet" "subnet-00cc72ac5b0b79dd4" {
  assign_ipv6_address_on_creation = false
  availability_zone               = "${var.region}-1a"
  cidr_block                      = "172.30.0.128/26"
  map_public_ip_on_launch         = false
  tags = {
    "Name"     = "cicd-private1"
    "workshop" = "cicd-private1"
  }
  vpc_id = aws_vpc.vpc-cicd.id

  timeouts {}
}

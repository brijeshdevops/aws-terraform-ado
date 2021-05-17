resource "aws_security_group" "main_security_group" {
  name_prefix = "sg_generic"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    cidr_blocks = [
      "${var.vpc_cidr}",
      "10.0.0.0/21",
      "172.16.0.0/12",
      "192.168.0.0/16",
      "167.219.0.0/16",
      "104.190.188.27/32" # My Home IP
    ]
  }
}


resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/21", "104.190.188.27/32", "192.168.0.0/16", "167.219.0.0/16"
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16", "104.190.188.27/32", "167.219.0.0/16"
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/21",
      "172.16.0.0/12",
      "192.168.0.0/16",
      "104.190.188.27/32",
      "167.219.0.0/16"
    ]
  }
}

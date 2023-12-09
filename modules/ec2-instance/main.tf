locals {
  serverconfig = [
    for srv in var.configuration : [
      for i in range(1, srv.no_of_instances + 1) : {
        instance_name = "${srv.application_name}-${i}"
        instance_type = srv.instance_type
        ami           = srv.ami
      }
    ]
  ]
}

locals {
  instances = flatten(local.serverconfig)
}


resource "aws_instance" "redhat_server" {
  for_each      = { for server in local.instances : server.instance_name => server }
  ami           = each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = "${each.value.instance_name}"
  }
  key_name               = "rhcsa"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  dynamic "ingress" {
    for_each = toset(var.allowed_ips)

    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


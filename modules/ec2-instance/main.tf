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

# resource "aws_ebs_volume" "redhat_volume" {
#   count = var.create_ebs ? length(aws_instance.redhat_server) : 0

#   availability_zone = values(aws_instance.redhat_server)[count.index].availability_zone
#   size              = var.size_of_volume
#   tags = {
#     Name = "redhat-volume-${count.index}",
#   }
# }




# resource "aws_volume_attachment" "redhat_volume_attachment" {
#   count          = var.instance_count * var.volume_count_per_instance
#   instance_id    = aws_instance.redhat_server[count.index % var.instance_count].id
#   volume_id      = aws_ebs_volume.redhat_volume[count.index].id
#   device_name    = "/dev/sdh"  # Specify the desired device name for attachment
# }

output "instance_public_ip" {
  value = module.redhat_server.instance-public-ip
  description = "The Public IP of the instance"

}
output "instance_public_dns" {
  value = module.redhat_server.instance-public-dns
  description = "The Public DNS of the instance"

}
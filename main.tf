
module "redhat_server" {
  source        = "./modules/ec2-instance"
  configuration = var.configuration
  allowed_ips   = var.allowed_ips
  # size_of_volume = var.size_of_volume
  # create_ebs     = true
}

# data "external" "get_public_ip" {
#   program = ["./get_public_ip.sh"]
# }

# output "public_ip" {
#   value = data.external.get_public_ip.result.public_ip
# }


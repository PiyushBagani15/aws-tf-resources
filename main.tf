
module "redhat_server" {
  source        = "./modules/ec2-instance"
  configuration = var.configuration
  allowed_ips   = var.allowed_ips
}

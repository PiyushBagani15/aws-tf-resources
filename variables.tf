variable "configuration" {
  description = "EC2 configuration"
  type        = map(any)
  default = {
    instance1 = {
      ami              = "ami-04708942c263d8190", # redhat ami
      instance_type    = "t2.micro",
      no_of_instances  = 1,
      application_name = "my redhat server"
    }
  }
}

variable "allowed_ips" {
  type        = list(string)
  description = "The IP address"
  default     = ["150.129.206.8/32"]
}

# variable "size_of_volume" {
#   description = "The size of the volume"
#   type        = number
# }
# variable "create_ebs" {
#   description = "Set to true if you want to create EBS volume, false otherwise"
#   type        = bool
#   default     = false
# }

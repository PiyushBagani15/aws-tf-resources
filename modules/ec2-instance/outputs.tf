output "instance-public-ip" {
  description = "The instance public IP address"
  value       = [for instance in aws_instance.redhat_server : instance.public_ip]
}

output "instance-public-dns" {
  description = "The instance public  DNS."
  value       = [for instance in aws_instance.redhat_server : instance.public_dns]

}
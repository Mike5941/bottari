output "ami_id" {
  value = data.aws_ami.amazon_linux2.id
}

output "alb_dns_name" {
  value = aws_lb.wordpress.dns_name
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "ami_id" {
  value = data.aws_ami.amazon_linux2.id
}

output "alb_dns_name" {
  value = aws_lb.wordpress.dns_name
}

#output "private_ip" {
#  value = aws_instance.web[*].private_ip
#}l
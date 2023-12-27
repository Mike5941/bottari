# output "alb_dns_name" {
#   value       = module.webserver_cluster.alb_dns_name
#   description = "The domain name of the load balancer"
# }

output "private_ip" {
  value       = module.primary_webserver.private_ip
  description = "The private IP address of the web server"
}

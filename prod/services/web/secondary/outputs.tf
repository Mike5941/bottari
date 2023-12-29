# output "alb_dns_name" {
#   value       = module.webserver_cluster.alb_dns_name
#   description = "The domain name of the load balancer"
# }

output "bastion_host_public_ip" {
  value = module.secondary_webserver.bastion_host_public_ip
}

 output "alb_dns_name" {
   value       = module.primary_webserver.alb_dns_name
   description = "The domain name of the load balancer"
 }

output "web_sg_id" {
  value = module.primary_webserver.web_sg_id
}
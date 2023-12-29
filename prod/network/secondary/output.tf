output "vpc_id" {
  description = "VPC ID"
  value = module.secondary.vpc_id
}

output "public_subnet" {
  description = "Public Subnet ID"
  value = module.secondary.public_subnets
}

output "private_subnet" {
  description = "Private Subnet ID"
  value = module.secondary.private_subnets
}

output "database_subnet" {
  description = "Database Subnet ID"
  value = module.secondary.database_subnets
}

output "azs"{
  value = module.secondary.azs
}

output "db_subnet_group" {
  description = "RDS Subnet Group Name"
  value = module.secondary.db_subnet_groups
}

output "cache_subnet_group" {
  description = "Cache Subnet Group Name"
  value = module.secondary.cache_subnet_groups
}

#output "vpn_endpoint_id" {
#  value = module.secondary.client_vpn_endpoint
#}
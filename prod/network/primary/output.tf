output "vpc_id" {
  description = "VPC ID"
  value = module.primary.vpc_id
}

output "public_subnet" {
  description = "Public Subnet ID"
  value = module.primary.public_subnets
}

output "private_subnet" {
  description = "Private Subnet ID"
  value = module.primary.private_subnets
}

output "database_subnet" {
  description = "Database Subnet ID"
  value = module.primary.database_subnets
}

output "azs"{
  value = module.primary.azs
}

output "db_subnet_group" {
  description = "RDS Subnet Group Name"
  value = module.primary.db_subnet_groups
}

output "cache_subnet_group" {
  description = "Cache Subnet Group Name"
  value = module.primary.cache_subnet_groups
}

output "vpn_endpoint_id" {
  value = module.primary.client_vpn_endpoint
}



output "primary_address" {
  value       = module.primary.address
  description = "Connect to the primary database at this endpoint"
}

output "primary_port" {
  value       = module.primary.port
  description = "The port the primary database is listening on"
}

output "primary_arn" {
  value       = module.primary.arn
  description = "The ARN of the primary database"
}

output "primary_dbname" {
  value       = module.primary.name
  description = "The name of the primary database"
}

output "secondary_dbname" {
  value       = module.secondary.name
  description = "The name of the primary database"
}

output "secondary_address" {
  value       = module.secondary.address
  description = "Connect to the primary database at this endpoint"
}

output "secondary_port" {
  value       = module.secondary.port
  description = "The port the primary database is listening on"
}

output "secondary_arn" {
  value       = module.secondary.arn
  description = "The ARN of the primary database"
}
output "redis_instance_id" {
  description = "Redis instance ID"
  value       = module.redis.dcs_instance_id
}

output "redis_endpoint" {
  description = "Redis connection endpoint"
  value       = module.redis.dcs_instance_endpoint
}

output "redis_domain_name" {
  description = "Redis domain name"
  value       = module.redis.dcs_instance_domain_name
}

output "redis_port" {
  description = "Redis port"
  value       = module.redis.dcs_instance_port
}

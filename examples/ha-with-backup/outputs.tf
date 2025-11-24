
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

output "redis_readonly_domain" {
  description = "Read-only domain name for HA instance"
  value       = module.redis.dcs_instance_readonly_domain_name
}

output "redis_port" {
  description = "Redis port"
  value       = module.redis.dcs_instance_port
}

output "redis_cache_mode" {
  description = "Cache mode (should be 'ha')"
  value       = module.redis.dcs_instance_cache_mode
}

output "redis_status" {
  description = "Redis instance status"
  value       = module.redis.dcs_instance_status
}

output "redis_private_ip" {
  description = "Private IP address"
  value       = module.redis.dcs_instance_private_ip
}

output "redis_max_memory" {
  description = "Total memory size in MB"
  value       = module.redis.dcs_instance_max_memory
}

output "redis_used_memory" {
  description = "Used memory size in MB"
  value       = module.redis.dcs_instance_used_memory
}

output "redis_replica_count" {
  description = "Number of replicas"
  value       = module.redis.dcs_instance_replica_count
}

output "redis_vpc_id" {
  description = "VPC ID"
  value       = module.redis.dcs_instance_vpc_id
}

output "redis_subnet_id" {
  description = "Subnet ID"
  value       = module.redis.dcs_instance_subnet_id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}

output "id" {
  description = "The DCS instance ID"
  value       = huaweicloud_dcs_instance.this.id
}

output "name" {
  description = "The DCS instance name"
  value       = huaweicloud_dcs_instance.this.name
}

output "status" {
  description = "The DCS instance status"
  value       = huaweicloud_dcs_instance.this.status
}

output "domain_name" {
  description = "Domain name of the instance"
  value       = huaweicloud_dcs_instance.this.domain_name
}

output "port" {
  description = "Port of the instance"
  value       = huaweicloud_dcs_instance.this.port
}

output "private_ip" {
  description = "Private IP of the instance"
  value       = huaweicloud_dcs_instance.this.private_ip
}

output "max_memory" {
  description = "Total memory size in MB"
  value       = huaweicloud_dcs_instance.this.max_memory
}

output "used_memory" {
  description = "Used memory size in MB"
  value       = huaweicloud_dcs_instance.this.used_memory
}

output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_dcs_instance.this.vpc_id
}

output "vpc_name" {
  description = "VPC name"
  value       = huaweicloud_dcs_instance.this.vpc_name
}

output "subnet_id" {
  description = "Subnet ID"
  value       = huaweicloud_dcs_instance.this.subnet_id
}

output "subnet_name" {
  description = "Subnet name"
  value       = huaweicloud_dcs_instance.this.subnet_name
}

output "subnet_cidr" {
  description = "Subnet CIDR"
  value       = huaweicloud_dcs_instance.this.subnet_cidr
}

output "security_group_id" {
  description = "Security group ID"
  value       = huaweicloud_dcs_instance.this.security_group_id
}

output "security_group_name" {
  description = "Security group name"
  value       = huaweicloud_dcs_instance.this.security_group_name
}

output "cache_mode" {
  description = "Cache mode (single, ha, cluster, proxy)"
  value       = huaweicloud_dcs_instance.this.cache_mode
}

output "cpu_type" {
  description = "CPU type (x86_64 or aarch64)"
  value       = huaweicloud_dcs_instance.this.cpu_type
}

output "readonly_domain_name" {
  description = "Read-only domain name (master/standby only)"
  value       = huaweicloud_dcs_instance.this.readonly_domain_name
}

output "replica_count" {
  description = "Number of replicas"
  value       = huaweicloud_dcs_instance.this.replica_count
}

output "sharding_count" {
  description = "Number of shards (cluster instances)"
  value       = huaweicloud_dcs_instance.this.sharding_count
}

output "product_type" {
  description = "Product type (generic or enterprise)"
  value       = huaweicloud_dcs_instance.this.product_type
}

output "engine" {
  description = "Cache engine"
  value       = huaweicloud_dcs_instance.this.engine
}

output "engine_version" {
  description = "Engine version"
  value       = huaweicloud_dcs_instance.this.engine_version
}

output "bandwidth_info" {
  description = "Bandwidth information"
  value       = huaweicloud_dcs_instance.this.bandwidth_info
}

output "created_at" {
  description = "Creation time in RFC3339 format"
  value       = huaweicloud_dcs_instance.this.created_at
}

output "launched_at" {
  description = "Launch time in RFC3339 format"
  value       = huaweicloud_dcs_instance.this.launched_at
}

output "order_id" {
  description = "Order ID (for prepaid instances)"
  value       = huaweicloud_dcs_instance.this.order_id
}

output "big_key_updated_at" {
  description = "Big key configuration update time"
  value       = huaweicloud_dcs_instance.this.big_key_updated_at
}

output "hot_key_updated_at" {
  description = "Hot key configuration update time"
  value       = huaweicloud_dcs_instance.this.hot_key_updated_at
}

output "expire_key_updated_at" {
  description = "Expire key configuration update time"
  value       = huaweicloud_dcs_instance.this.expire_key_updated_at
}

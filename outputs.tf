################################################################################
# DCS Instance
################################################################################

output "dcs_instance_id" {
  description = "The DCS instance ID"
  value       = try(module.dcs_instance[0].id, null)
}

output "dcs_instance_name" {
  description = "The DCS instance name"
  value       = try(module.dcs_instance[0].name, null)
}

output "dcs_instance_status" {
  description = "The DCS instance status"
  value       = try(module.dcs_instance[0].status, null)
}

output "dcs_instance_domain_name" {
  description = "Domain name of the instance for connections"
  value       = try(module.dcs_instance[0].domain_name, null)
}

output "dcs_instance_endpoint" {
  description = "The connection endpoint in domain:port format"
  value       = try("${module.dcs_instance[0].domain_name}:${module.dcs_instance[0].port}", null)
}

output "dcs_instance_port" {
  description = "The port of the DCS instance"
  value       = try(module.dcs_instance[0].port, null)
}

output "dcs_instance_private_ip" {
  description = "Private IP address of the DCS instance"
  value       = try(module.dcs_instance[0].private_ip, null)
}

output "dcs_instance_readonly_domain_name" {
  description = "Read-only domain name (available for master/standby instances)"
  value       = try(module.dcs_instance[0].readonly_domain_name, null)
}

output "dcs_instance_max_memory" {
  description = "Total memory size in MB"
  value       = try(module.dcs_instance[0].max_memory, null)
}

output "dcs_instance_used_memory" {
  description = "Used memory size in MB"
  value       = try(module.dcs_instance[0].used_memory, null)
}

output "dcs_instance_engine" {
  description = "The cache engine"
  value       = try(module.dcs_instance[0].engine, var.engine)
}

output "dcs_instance_engine_version" {
  description = "The engine version"
  value       = try(module.dcs_instance[0].engine_version, var.engine_version)
}

output "dcs_instance_cache_mode" {
  description = "Cache mode (single, ha, cluster, proxy)"
  value       = try(module.dcs_instance[0].cache_mode, null)
}

output "dcs_instance_cpu_type" {
  description = "CPU type (x86_64 or aarch64)"
  value       = try(module.dcs_instance[0].cpu_type, null)
}

output "dcs_instance_product_type" {
  description = "Product type (generic or enterprise)"
  value       = try(module.dcs_instance[0].product_type, null)
}

output "dcs_instance_replica_count" {
  description = "Number of replicas in the instance"
  value       = try(module.dcs_instance[0].replica_count, null)
}

output "dcs_instance_sharding_count" {
  description = "Number of shards in cluster instance"
  value       = try(module.dcs_instance[0].sharding_count, null)
}

################################################################################
# Network Information
################################################################################

output "dcs_instance_vpc_id" {
  description = "VPC ID of the DCS instance"
  value       = try(module.dcs_instance[0].vpc_id, null)
}

output "dcs_instance_vpc_name" {
  description = "VPC name of the DCS instance"
  value       = try(module.dcs_instance[0].vpc_name, null)
}

output "dcs_instance_subnet_id" {
  description = "Subnet ID of the DCS instance"
  value       = try(module.dcs_instance[0].subnet_id, null)
}

output "dcs_instance_subnet_name" {
  description = "Subnet name of the DCS instance"
  value       = try(module.dcs_instance[0].subnet_name, null)
}

output "dcs_instance_subnet_cidr" {
  description = "Subnet CIDR of the DCS instance"
  value       = try(module.dcs_instance[0].subnet_cidr, null)
}

output "dcs_instance_security_group_id" {
  description = "Security group ID of the DCS instance"
  value       = try(module.dcs_instance[0].security_group_id, null)
}

output "dcs_instance_security_group_name" {
  description = "Security group name of the DCS instance"
  value       = try(module.dcs_instance[0].security_group_name, null)
}

################################################################################
# EIP and Public Access
################################################################################

output "eip_id" {
  description = "The EIP ID associated with the DCS instance"
  value       = try(huaweicloud_vpc_eip.this[0].id, null)
}

output "eip_address" {
  description = "The public IP address of the EIP"
  value       = try(huaweicloud_vpc_eip.this[0].address, null)
}

output "eip_status" {
  description = "The status of the EIP"
  value       = try(huaweicloud_vpc_eip.this[0].status, null)
}

output "public_access_enabled" {
  description = "Whether public access is enabled"
  value       = var.enable_public_access
}

output "public_access_eip_id" {
  description = "The EIP ID from public access resource (same as eip_id)"
  value       = try(huaweicloud_dcs_instance_public_access.this[0].eip_id, null)
}

output "public_access_eip_address" {
  description = "The EIP address from public access resource"
  value       = try(huaweicloud_dcs_instance_public_access.this[0].eip_address, null)
}

################################################################################
# Bandwidth Information
################################################################################

output "dcs_instance_bandwidth_info" {
  description = "Bandwidth information of the instance"
  value       = try(module.dcs_instance[0].bandwidth_info, null)
}

################################################################################
# Timestamps
################################################################################

output "dcs_instance_created_at" {
  description = "Instance creation time in RFC3339 format"
  value       = try(module.dcs_instance[0].created_at, null)
}

output "dcs_instance_launched_at" {
  description = "Instance launch time in RFC3339 format"
  value       = try(module.dcs_instance[0].launched_at, null)
}

output "dcs_instance_order_id" {
  description = "Order ID (for prepaid instances)"
  value       = try(module.dcs_instance[0].order_id, null)
}

################################################################################
# Cache Analysis Timestamps
################################################################################

output "dcs_instance_big_key_updated_at" {
  description = "Big key configuration update time"
  value       = try(module.dcs_instance[0].big_key_updated_at, null)
}

output "dcs_instance_hot_key_updated_at" {
  description = "Hot key configuration update time"
  value       = try(module.dcs_instance[0].hot_key_updated_at, null)
}

output "dcs_instance_expire_key_updated_at" {
  description = "Expire key configuration update time"
  value       = try(module.dcs_instance[0].expire_key_updated_at, null)
}

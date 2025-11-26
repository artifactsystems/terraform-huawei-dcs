variable "region" {
  description = "The region in which to create the DCS instance"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the DCS instance"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name as a prefix"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Cache engine (Redis or Memcached)"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "capacity" {
  description = "Cache capacity in GB"
  type        = number
}

variable "flavor" {
  description = "Flavor of the cache instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "password" {
  description = "Password for the DCS instance"
  type        = string
  sensitive   = true
  default     = null
}

variable "port" {
  description = "Port number"
  type        = number
  default     = null
}

variable "private_ip" {
  description = "Private IP address"
  type        = string
  default     = null
}

variable "ssl_enable" {
  description = "Enable SSL"
  type        = bool
  default     = null
}

variable "whitelists" {
  description = "IP address whitelists"
  type = list(object({
    group_name = string
    ip_address = list(string)
  }))
  default = []
}

variable "whitelist_enable" {
  description = "Enable IP whitelist"
  type        = bool
  default     = true
}

variable "backup_policy" {
  description = "Backup configuration"
  type = object({
    backup_type = optional(string, "auto")
    save_days   = optional(number)
    period_type = optional(string, "weekly")
    backup_at   = list(number)
    begin_at    = string
  })
  default = null
}

variable "maintain_begin" {
  description = "Maintenance window start time"
  type        = string
  default     = null
}

variable "maintain_end" {
  description = "Maintenance window end time"
  type        = string
  default     = null
}

variable "template_id" {
  description = "Parameter template ID"
  type        = string
  default     = null
}

variable "parameters" {
  description = "Configuration parameters"
  type = list(object({
    id    = string
    name  = string
    value = string
  }))
  default = []
}

variable "rename_commands" {
  description = "Command renaming for critical commands"
  type        = map(string)
  default     = {}
}

variable "big_key_enable_auto_scan" {
  description = "Enable big key auto scan"
  type        = bool
  default     = false
}

variable "big_key_schedule_at" {
  description = "Big key scan schedule"
  type        = list(string)
  default     = []
}

variable "hot_key_enable_auto_scan" {
  description = "Enable hot key auto scan"
  type        = bool
  default     = false
}

variable "hot_key_schedule_at" {
  description = "Hot key scan schedule"
  type        = list(string)
  default     = []
}

variable "expire_key_enable_auto_scan" {
  description = "Enable expire key auto scan"
  type        = bool
  default     = false
}

variable "expire_key_first_scan_at" {
  description = "First scan time for expire key"
  type        = string
  default     = null
}

variable "expire_key_interval" {
  description = "Expire key scan interval"
  type        = number
  default     = null
}

variable "expire_key_timeout" {
  description = "Expire key scan timeout"
  type        = number
  default     = null
}

variable "expire_key_scan_keys_count" {
  description = "Number of keys scanned per iteration"
  type        = number
  default     = null
}

variable "transparent_client_ip_enable" {
  description = "Enable client IP pass-through"
  type        = bool
  default     = null
}

variable "enterprise_project_id" {
  description = "Enterprise project ID"
  type        = string
  default     = null
}

variable "description" {
  description = "Instance description"
  type        = string
  default     = null
}

variable "charging_mode" {
  description = "Charging mode"
  type        = string
  default     = "postPaid"
}

variable "period_unit" {
  description = "Period unit"
  type        = string
  default     = null
}

variable "period" {
  description = "Billing period"
  type        = number
  default     = null
}

variable "auto_renew" {
  description = "Auto renew"
  type        = string
  default     = null
}

variable "deleted_nodes" {
  description = "Node IDs to delete"
  type        = list(string)
  default     = []
}

variable "reserved_ips" {
  description = "IPs to reserve during scale-in"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the instance"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Timeouts configuration"
  type        = map(string)
  default     = {}
}

################################################################################
# General
################################################################################

variable "create" {
  description = "Whether to create DCS resources"
  type        = bool
  default     = true
}

variable "region" {
  description = "The Huawei Cloud region where resources will be created. If not specified, the region configured in the provider will be used"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "dcs_instance_tags" {
  description = "Additional tags for the DCS instance"
  type        = map(string)
  default     = {}
}

################################################################################
# DCS Instance
################################################################################

variable "create_dcs_instance" {
  description = "Whether to create a DCS instance"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The name of the DCS instance. Must be 4 to 64 characters and start with a letter"
  type        = string
}

variable "use_identifier_prefix" {
  description = "Determines whether to use `identifier` as is or create a unique identifier beginning with `identifier` as the specified prefix"
  type        = bool
  default     = false
}

variable "engine" {
  description = "The cache engine to use. Only Redis is supported"
  type        = string
  default     = "Redis"

  validation {
    condition     = var.engine == "Redis"
    error_message = "Engine must be 'Redis'. Memcached is deprecated and not supported by this module."
  }
}

variable "engine_version" {
  description = "The engine version to use. For Redis: 3.0, 4.0, 5.0, 6.0. Mandatory when engine is Redis"
  type        = string
  default     = null
}

variable "capacity" {
  description = <<-EOF
    The cache capacity in GB. Valid values depend on Redis version and mode:
    - Redis 4.0/5.0/6.0 standalone/ha: 0.125, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64
    - Redis 4.0/5.0/6.0 cluster: 4, 8, 16, 24, 32, 48, 64, 96, 128, 192, 256, 384, 512, 768, 1024
    - Redis 3.0 standalone/ha: 2, 4, 8, 16, 32, 64
    - Redis 3.0 proxy cluster: 64, 128, 256, 512, 1024
  EOF
  type        = number
}

variable "flavor" {
  description = <<-EOF
    The flavor of the cache instance. Can be obtained via:
    - data source: huaweicloud_dcs_flavors
    - DCS console or documentation
    Example: redis.ha.xu1.large.r2.4
  EOF
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the DCS instance will be created"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the DCS instance will be created"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the DCS instance. Mandatory for Redis 3.0"
  type        = string
  default     = null
}

variable "availability_zones" {
  description = <<-EOF
    List of availability zones for the DCS instance.
    - Single element for single node
    - Two elements for master/standby (first is primary, second is standby)
    - Multiple elements for cluster mode
  EOF
  type        = list(string)
}

################################################################################
# DCS Authentication & Access
################################################################################

variable "password" {
  description = <<-EOF
    Password for the Redis instance. Must meet complexity requirements:
    - 8-32 characters
    - Contains three of: uppercase, lowercase, digits, special chars (`~!@#$^&*()-_=+\|{}:,<.>/?)
  EOF
  type        = string
  sensitive   = true
  default     = null
}

variable "port" {
  description = "Port customization, supported only by Redis 4.0 and 5.0. Defaults to 6379 for Redis"
  type        = number
  default     = null
}

variable "private_ip" {
  description = "The IP address of the DCS instance. If omitted, system automatically allocates one. Not supported for Redis Cluster"
  type        = string
  default     = null
}

variable "ssl_enable" {
  description = "Whether to enable SSL encryption"
  type        = bool
  default     = null
}

################################################################################
# Whitelist Configuration
################################################################################

variable "whitelists" {
  description = <<-EOF
    IP address whitelists for the instance. Valid for Redis 4.0, 5.0, 6.0.
    Each whitelist group can contain up to 20 IP addresses or CIDR blocks.

    Example:
    [
      {
        group_name = "office-network"
        ip_address = ["192.168.1.0/24", "10.0.0.100"]
      },
      {
        group_name = "app-servers"
        ip_address = ["172.16.0.0/16"]
      }
    ]
  EOF
  type = list(object({
    group_name = string
    ip_address = list(string)
  }))
  default = []
}

variable "whitelist_enable" {
  description = "Enable or disable IP address whitelists. If disabled, all IPs in the VPC can access. Defaults to true"
  type        = bool
  default     = true
}

################################################################################
# Backup Policy
################################################################################

variable "backup_policy" {
  description = <<-EOF
    Backup configuration for the DCS instance. Not supported for single node instances.

    Example:
    {
      backup_type = "auto"
      save_days   = 7
      backup_at   = [1, 3, 5, 7]  # Monday, Wednesday, Friday, Sunday
      begin_at    = "02:00-04:00"
    }
  EOF
  type = object({
    backup_type = optional(string, "auto")
    save_days   = optional(number)
    period_type = optional(string, "weekly")
    backup_at   = list(number)
    begin_at    = string
  })
  default = null
}

################################################################################
# Maintenance Window
################################################################################

variable "maintain_begin" {
  description = "Time at which maintenance window starts. Format: HH:00:00 (must be on the hour). Defaults to 02:00:00"
  type        = string
  default     = null
}

variable "maintain_end" {
  description = "Time at which maintenance window ends. Must be one hour after maintain_begin. Defaults to 06:00:00"
  type        = string
  default     = null
}

################################################################################
# Parameters & Configuration
################################################################################

variable "template_id" {
  description = "The Parameter Template ID to use for the instance"
  type        = string
  default     = null
}

variable "parameters" {
  description = <<-EOF
    List of configuration parameters to set on the DCS instance.

    Example:
    [
      {
        id    = "1"
        name  = "timeout"
        value = "500"
      },
      {
        id    = "3"
        name  = "hash-max-ziplist-entries"
        value = "4096"
      }
    ]
  EOF
  type = list(object({
    id    = string
    name  = string
    value = string
  }))
  default = []
}

variable "rename_commands" {
  description = <<-EOF
    Critical command renaming for Redis 4.0 and 5.0 (not supported in 3.0).
    Valid commands: command, keys, flushdb, flushall, hgetall, scan, hscan, sscan, zscan

    Example:
    {
      flushdb  = "my_flushdb_cmd"
      flushall = "my_flushall_cmd"
      keys     = "my_keys_cmd"
    }
  EOF
  type        = map(string)
  default     = {}
}

################################################################################
# Cache Analysis (Big Key, Hot Key, Expire Key)
################################################################################

variable "big_key_enable_auto_scan" {
  description = "Enable scheduled cache analysis for big keys"
  type        = bool
  default     = false
}

variable "big_key_schedule_at" {
  description = "UTC time of day for big key analysis schedule. Example: ['00:00', '12:00']"
  type        = list(string)
  default     = []
}

variable "hot_key_enable_auto_scan" {
  description = "Enable scheduled cache analysis for hot keys"
  type        = bool
  default     = false
}

variable "hot_key_schedule_at" {
  description = "UTC time of day for hot key analysis schedule. Example: ['00:00', '12:00']"
  type        = list(string)
  default     = []
}

variable "expire_key_enable_auto_scan" {
  description = "Enable scheduled cache analysis for expire keys"
  type        = bool
  default     = false
}

variable "expire_key_first_scan_at" {
  description = "First scan time for expire key analysis. Format: RFC3339 (e.g., 2023-07-07T15:00:05.000z). Mandatory when expire_key_enable_auto_scan is true"
  type        = string
  default     = null
}

variable "expire_key_interval" {
  description = "Scan interval for expire keys in seconds. Mandatory when expire_key_enable_auto_scan is true"
  type        = number
  default     = null
}

variable "expire_key_timeout" {
  description = "Scan timeout for expire keys in seconds. Must be at least twice the interval. Mandatory when expire_key_enable_auto_scan is true"
  type        = number
  default     = null
}

variable "expire_key_scan_keys_count" {
  description = "Number of keys scanned per iteration for expire key analysis. Mandatory when expire_key_enable_auto_scan is true"
  type        = number
  default     = null
}

################################################################################
# Advanced Settings
################################################################################

variable "transparent_client_ip_enable" {
  description = "Whether client IP pass-through is enabled"
  type        = bool
  default     = null
}

variable "enterprise_project_id" {
  description = "The enterprise project ID for the DCS instance"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the DCS instance. Maximum 1024 characters"
  type        = string
  default     = null
}

################################################################################
# Billing Configuration
################################################################################

variable "charging_mode" {
  description = "Charging mode of the DCS instance. Valid values: 'prePaid' (yearly/monthly), 'postPaid' (pay-per-use, default)"
  type        = string
  default     = "postPaid"

  validation {
    condition     = contains(["prePaid", "postPaid"], var.charging_mode)
    error_message = "charging_mode must be either 'prePaid' or 'postPaid'."
  }
}

variable "period_unit" {
  description = "Charging period unit. Required when charging_mode is 'prePaid'. Valid values: 'month', 'year'"
  type        = string
  default     = null
}

variable "period" {
  description = "Charging period. Required when charging_mode is 'prePaid'. Valid: 1-9 (month), 1-3 (year)"
  type        = number
  default     = null
}

variable "auto_renew" {
  description = "Whether to automatically renew prepaid instance. Valid values: 'true', 'false'"
  type        = string
  default     = null
}

################################################################################
# Public Access (EIP)
################################################################################

variable "enable_public_access" {
  description = "Whether to enable public access to the DCS instance by associating an EIP"
  type        = bool
  default     = false
}

variable "eip_type" {
  description = "The EIP type. Valid values: '5_bgp' (dynamic BGP), '5_sbgp' (static BGP)"
  type        = string
  default     = "5_bgp"
}

variable "eip_bandwidth_name" {
  description = "The bandwidth name for the EIP. If not provided, defaults to '{identifier}-eip'"
  type        = string
  default     = null
}

variable "eip_bandwidth_size" {
  description = "The bandwidth size in Mbit/s. Value ranges from 1 to 300"
  type        = number
  default     = 10
}

variable "eip_bandwidth_charge_mode" {
  description = "Bandwidth billing mode. Valid values: 'traffic', 'bandwidth'"
  type        = string
  default     = "traffic"
}

################################################################################
# Scaling Operations
################################################################################

variable "deleted_nodes" {
  description = "IDs of replicas to delete. Mandatory when deleting replicas of master/standby Redis 4.0/5.0. Only one replica can be deleted at a time"
  type        = list(string)
  default     = []
}

variable "reserved_ips" {
  description = "IP addresses to retain during cluster scale-in. If not set, system randomly deletes shards"
  type        = list(string)
  default     = []
}

################################################################################
# Timeouts
################################################################################

variable "timeouts" {
  description = "Terraform resource management timeouts"
  type        = map(string)
  default     = {}
}

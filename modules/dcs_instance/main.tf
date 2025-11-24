resource "huaweicloud_dcs_instance" "this" {
  region             = var.region
  name               = var.use_name_prefix ? null : var.name
  engine             = var.engine
  engine_version     = var.engine_version
  capacity           = var.capacity
  flavor             = var.flavor
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  security_group_id  = var.security_group_id
  availability_zones = var.availability_zones

  password   = var.password
  port       = var.port
  private_ip = var.private_ip
  ssl_enable = var.ssl_enable

  whitelist_enable = var.whitelist_enable

  dynamic "whitelists" {
    for_each = var.whitelists
    content {
      group_name = whitelists.value.group_name
      ip_address = whitelists.value.ip_address
    }
  }

  dynamic "backup_policy" {
    for_each = var.backup_policy != null ? [var.backup_policy] : []
    content {
      backup_type = backup_policy.value.backup_type
      save_days   = backup_policy.value.save_days
      period_type = backup_policy.value.period_type
      backup_at   = backup_policy.value.backup_at
      begin_at    = backup_policy.value.begin_at
    }
  }

  maintain_begin = var.maintain_begin
  maintain_end   = var.maintain_end

  template_id     = var.template_id
  rename_commands = var.rename_commands

  dynamic "parameters" {
    for_each = var.parameters
    content {
      id    = parameters.value.id
      name  = parameters.value.name
      value = parameters.value.value
    }
  }

  big_key_enable_auto_scan = var.big_key_enable_auto_scan
  big_key_schedule_at      = var.big_key_schedule_at
  hot_key_enable_auto_scan = var.hot_key_enable_auto_scan
  hot_key_schedule_at      = var.hot_key_schedule_at

  expire_key_enable_auto_scan = var.expire_key_enable_auto_scan
  expire_key_first_scan_at    = var.expire_key_first_scan_at
  expire_key_interval         = var.expire_key_interval
  expire_key_timeout          = var.expire_key_timeout
  expire_key_scan_keys_count  = var.expire_key_scan_keys_count

  transparent_client_ip_enable = var.transparent_client_ip_enable
  enterprise_project_id        = var.enterprise_project_id
  description                  = var.description

  charging_mode = var.charging_mode
  period_unit   = var.period_unit
  period        = var.period
  auto_renew    = var.auto_renew

  deleted_nodes = var.deleted_nodes
  reserved_ips  = var.reserved_ips

  tags = var.tags

  dynamic "timeouts" {
    for_each = length(var.timeouts) > 0 ? [var.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      # Ignore changes to name if using name prefix
      name,
    ]
  }
}

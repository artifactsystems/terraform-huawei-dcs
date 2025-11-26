locals {
  create_dcs_instance = var.create_dcs_instance && var.create

  # Instance name with optional prefix
  instance_name = var.use_identifier_prefix ? null : var.identifier

  # Maintenance window parsing
  maintenance_begin = var.maintain_begin
  maintenance_end   = var.maintain_end
}

################################################################################
# DCS Instance
################################################################################

module "dcs_instance" {
  count  = local.create_dcs_instance ? 1 : 0
  source = "./modules/dcs_instance"

  region             = var.region
  name               = local.instance_name
  use_name_prefix    = var.use_identifier_prefix
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

  whitelists       = var.whitelists
  whitelist_enable = var.whitelist_enable

  backup_policy = var.backup_policy

  maintain_begin = local.maintenance_begin
  maintain_end   = local.maintenance_end

  template_id     = var.template_id
  parameters      = var.parameters
  rename_commands = var.rename_commands

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

  tags = merge(var.tags, var.dcs_instance_tags)

  timeouts = var.timeouts
}

################################################################################
# EIP and Public Access
################################################################################

resource "huaweicloud_vpc_eip" "this" {
  count = var.enable_public_access ? 1 : 0

  publicip {
    type = var.eip_type
  }

  bandwidth {
    share_type  = "PER"
    name        = var.eip_bandwidth_name != null ? var.eip_bandwidth_name : "${var.identifier}-eip"
    size        = var.eip_bandwidth_size
    charge_mode = var.eip_bandwidth_charge_mode
  }

  tags = var.tags
}

resource "huaweicloud_dcs_instance_public_access" "this" {
  count = var.enable_public_access ? 1 : 0

  instance_id = module.dcs_instance[0].id
  publicip_id = huaweicloud_vpc_eip.this[0].id

  depends_on = [module.dcs_instance, huaweicloud_vpc_eip.this]
}

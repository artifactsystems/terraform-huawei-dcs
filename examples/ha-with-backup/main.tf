provider "huaweicloud" {
  region = local.region
}

data "huaweicloud_availability_zones" "available" {}

locals {
  name   = "redis-ha-backup"
  region = "tr-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.huaweicloud_availability_zones.available.names, 0, 2)

  tags = {
    Name    = local.name
    Example = "ha-with-backup"
  }
}

################################################################################
# DCS Module - HA Redis with Backup Policy
################################################################################

module "redis" {
  source = "../../"

  identifier         = local.name
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = 4
  flavor             = "redis.ha.xu1.large.r2.4"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.private_subnets[0]
  availability_zones = local.azs

  password = "YourPassword@123"

  backup_policy = {
    backup_type = "auto"
    save_days   = 3
    backup_at   = [1, 3, 5, 7] # Monday, Wednesday, Friday, Sunday
    begin_at    = "02:00-04:00"
  }

  # Whitelist configuration
  whitelists = [
    {
      group_name = "test-group1"
      ip_address = ["192.168.10.100", "192.168.0.0/24"]
    },
    {
      group_name = "test-group2"
      ip_address = ["172.16.10.100", "172.16.0.0/24"]
    }
  ]

  parameters = [
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

  # Billing configuration
  charging_mode = "postPaid"
  # Uncomment below for prepaid mode
  # charging_mode = "prePaid"
  # period_unit   = "month"
  # period        = 1
  # auto_renew    = "true"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source = "github.com/artifactsystems/terraform-huawei-vpc?ref=v1.0.0"

  name = local.name
  cidr = local.vpc_cidr

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]

  tags = local.tags
}

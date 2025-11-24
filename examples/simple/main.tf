provider "huaweicloud" {
  region = local.region
}

data "huaweicloud_availability_zones" "available" {}

locals {
  name   = "simple-redis"
  region = "tr-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.huaweicloud_availability_zones.available.names, 0, 1)

  tags = {
    Name    = local.name
    Example = local.name
  }
}

################################################################################
# DCS Module - Simple Redis
################################################################################

module "redis" {
  source = "../../"

  identifier         = local.name
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = 2
  flavor             = "redis.single.xu1.large.2"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.private_subnets[0]
  availability_zones = local.azs

  password = "YourPassword@123"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source = "../../../terraform-huawei-vpc"

  name = local.name
  cidr = local.vpc_cidr

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]

  tags = local.tags
}

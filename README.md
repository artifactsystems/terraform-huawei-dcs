# HuaweiCloud DCS Terraform Module

This repository provides Terraform modules and working examples for provisioning HuaweiCloud Distributed Cache Service (Redis/Memcached) resources.

## Features

- ✅ Single, HA, or cluster Redis/Memcached instances
- ✅ VPC, subnet, and security group integration
- ✅ Password, IP whitelist, SSL, and command renaming controls
- ✅ Backup policies, maintenance windows, parameter templates
- ✅ Automated big/hot/expire key scan schedules

## Repository Layout

- `main.tf`, `variables.tf`, `outputs.tf`: root module
- `modules/dcs_instance`: reusable submodule for a single DCS instance
- `examples/`: ready-to-run configurations
  - `simple`: basic Redis instance
  - `ha-with-backup`: HA deployment with backups enabled

## Quick Start

```hcl
module "dcs" {
  source = "github.com/artifactsystems/terraform-huawei-dcs?ref=v1.0.0"

  region             = "tr-west-1"
  name               = "redis-cache"
  engine             = "Redis"
  engine_version     = "6.0"
  capacity           = 2
  flavor             = "redis.ha.xu1.large.2"
  availability_zones = ["tr-west-1a", "tr-west-1b"]

  vpc_id            = "vpc-id"
  subnet_id         = "subnet-id"
  security_group_id = "sg-id"
  password          = "StrongPassw0rd!"

  tags = {
    Environment = "prod"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| huaweicloud | >= 1.79.0 |

## References

- Resource: [`huaweicloud_dcs_instance`](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/dcs_instance)
- Examples: `examples/simple`, `examples/ha-with-backup`

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/artifactsystems/terraform-huawei-dcs/issues/new) section.

Full contributing [guidelines are covered here](.github/CONTRIBUTING.md).

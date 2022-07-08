module "security_group_replica" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.region2
  }

  name        = "${local.name}-mastersg"
  description = "Replica PostgreSQL example security group"
#  vpc_id      = module.vpc_region2.vpc_id
  vpc_id      = data.terraform_remote_state.vpc_region2.outputs.region2_vpc_id
  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks  = data.terraform_remote_state.vpc_region2.outputs.region2_vpc_cidr_block
},
  ]
  egress_rules = ["all-all"]

  tags = local.common_tags
}


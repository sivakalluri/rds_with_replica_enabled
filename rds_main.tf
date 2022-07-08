################################################################################
# Master DB
################################################################################

module "master" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.3.0"

  engine                = local.engine
  engine_version        = local.engine_version
  family                = local.family
  major_engine_version  = local.major_engine_version
  instance_class        = local.instance_class
  storage_encrypted     = local.db_storage_encrypted
  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  
  # Backups are required in order to create a replica
  backup_retention_period = local.master_backup_retention_period
  skip_final_snapshot     = local.skip_final_snapshot
  deletion_protection     = local.deletion_protection

  # Username and password 
  identifier = var.db_instance_identifier
  db_name    = var.db_name 
  username   = var.db_username
  password   = var.db_password
  multi_az   = var.master_multi_az

#  db_subnet_group_name   = module.vpc.database_subnet_group_name
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.db_subnet_group_name
  vpc_security_group_ids = [module.security_group_master.security_group_id]


  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = local.common_tags
}

################################################################################
# Replica DB
################################################################################

module "replica" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.3.0"

  providers = {
    aws = aws.region2
  }

  # Source database. For cross-region use db_instance_arn
  replicate_source_db    = module.master.db_instance_arn
  create_random_password = false

  engine                = local.engine
  engine_version        = local.engine_version
  family                = local.family
  major_engine_version  = local.major_engine_version
  instance_class        = local.instance_class
  storage_encrypted     = local.db_storage_encrypted
  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage

  backup_retention_period = local.replica_backup_retention_period
  skip_final_snapshot     = local.skip_final_snapshot
  deletion_protection     = local.deletion_protection

  # Username and password should not be set for replicas
  identifier = var.replica_db_instance_identifier
  username   = null
  password   = null
  multi_az   = var.replica_multi_az

 # Specify a subnet group created in the replica region
#  db_subnet_group_name   = module.vpc_region2.database_subnet_group_name
  db_subnet_group_name   = data.terraform_remote_state.vpc_region2.outputs.region2_db_subnet_group_name
  vpc_security_group_ids = [module.security_group_replica.security_group_id]

  maintenance_window              = "Tue:00:00-Tue:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  kms_key_id              = aws_kms_key.db_rep_enc.arn

  tags = local.common_tags
}

resource "aws_kms_key" "db_rep_enc" {
  description = "Encryption key for automated backups"
  provider = aws.region2
}
/*
resource "aws_db_instance_automated_backups_replication" "default" {
  provider = aws.region2
  source_db_instance_arn = module.master.db_instance_arn
  kms_key_id             = aws_kms_key.db_rep_enc.arn
}
*/



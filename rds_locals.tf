locals {
  engine                = "postgres"
  engine_version        = "14.1"
  family                = "postgres14" # DB parameter group
  major_engine_version  = "14"         # DB option group
  instance_class        = "db.t3.micro"
  allocated_storage     = 5
  max_allocated_storage = 20
  port                  = 5432
  db_storage_encrypted  = true
  skip_final_snapshot   = true
  deletion_protection   = false
  master_backup_retention_period  = 1
  replica_backup_retention_period = 0
}

# Terraform AWS RDS Database Variables
# Place holder file for AWS RDS Database

# DB Name
variable "db_name" {
  description = "AWS RDS Database Name"
  type        = string
}

# DB Instance Identifier
variable "db_instance_identifier" {
  description = "AWS RDS Database Instance Identifier"
  type        = string
}

# DB Username - Enable Sensitive flag
variable "db_username" {
  description = "AWS RDS Database Administrator Username"
  type        = string
}

# DB Password - Enable Sensitive flag
variable "db_password" {
  description = "AWS RDS Database Administrator Password"
  type        = string
  sensitive   = true
}

# Master Multi AZ avaivalability
variable "master_multi_az" {
  description = "AWS RDS Database Multi AZ Availability for master"
  type        = bool
}


# Replica DB Name
variable "replica_db_name" {
  description = "AWS RDS Database Name"
  type        = string
}

# Replica DB Instance Identifier
variable "replica_db_instance_identifier" {
  description = "AWS RDS Database Instance Identifier"
  type        = string
}

# Replica Multi AZ avaivalability
variable "replica_multi_az" {
  description = "AWS RDS Database Multi AZ Availability for replica"
  type        = bool
}


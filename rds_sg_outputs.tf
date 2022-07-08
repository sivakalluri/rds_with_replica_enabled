## SG of RDS Master
output "master_security_group_id" {
  description = "The ID of RDS security group"
  value       = module.security_group_master.security_group_id
}

## SG of RDS Replica
output "Replica_security_group_id" {
  description = "The ID of RDS REPLICA security group"
  value       = module.security_group_replica.security_group_id
}


resource "random_password" "db"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

# ### RDS Subnet Group ###

resource "aws_db_subnet_group" "rds-sg" {
    description = "${var.env}-db-sg"
    name = "${var.env}-db-sg"
    subnet_ids = var.rds-subnet
  
}


# ### RDS Parameter Group ###

resource "aws_db_parameter_group" "rds-pg" {
    count        = length(var.db_name)
    description = "${var.env}-pg"
    family = var.rds-family-pg[count.index]
    name = var.rds-family-name[count.index]
}

  

### RDS ###

resource "aws_db_instance" "rds" {
    count = length(var.db_name)
    identifier = var.db_name[count.index]
    db_name = var.db_name[count.index]
    instance_class = var.instance-class[count.index]
    max_allocated_storage = var.max-auto-storage
    allocated_storage = var.storage
    auto_minor_version_upgrade = true   
    backup_retention_period = var.backup_period
    copy_tags_to_snapshot = "false"
    db_subnet_group_name = aws_db_subnet_group.rds-sg.name
    engine = var.rds-engine[count.index]
    engine_version = var.rds-engine-version[count.index]
    multi_az = var.multi_az
    parameter_group_name = aws_db_parameter_group.rds-pg[count.index].name
    performance_insights_enabled = var.rds-performance-insights
    performance_insights_retention_period = var.rds-performance-ins-retention
    port = var.db-port[count.index]
    publicly_accessible = var.public-access
    storage_type = var.storage-type
    skip_final_snapshot = var.skip-final-snapshot
    username = var.rds-username[count.index]
    password = "truemeds123"
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    deletion_protection = true
    final_snapshot_identifier = "${var.db_name[count.index]}"

    tags = {
    Environment = var.env
  }
}


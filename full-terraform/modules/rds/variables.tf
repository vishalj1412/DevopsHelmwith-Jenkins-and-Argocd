variable "env" {}
variable "client" {}
variable "instance-class" {}
variable "rds-subnet" {}
variable "storage-type" {}
variable "storage" {}
variable "rds-engine" {}
variable "rds-engine-version" {}
variable "db_name" {}
variable "rds-username" {}
variable "rds-family-pg" {}
variable "backup_period" {}
variable "max-auto-storage" {}
variable "rds-performance-ins-retention" {}
variable "db-port" {}
#variable "rds-db-sg" {}
#variable "rds-password" {}
variable "rds-performance-insights" {
    type = bool
}
variable "public-access" {
    type = bool 
    }
variable "encrytion" {
    type = bool
}
variable "multi_az" {
  type = bool
}
variable "skip-final-snapshot" {
 type = bool
}
variable "vpc" {}

variable "rds-family-name"{
    default = ["dev-pg","dev-postgres-pg"]
}

variable "db_cidr"{}
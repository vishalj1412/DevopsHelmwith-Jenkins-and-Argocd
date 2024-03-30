#####  VPC  #####
module "vpc" {
  source                        = "../../modules/vpc"
  region                        = var.region
  env                           = var.env
  cidr                          = var.cidr
  account                       = var.account
  Retention                     = var.Retention
  eks_name                      = ["prod-warehouse-cluster","prod-app-cluster"]
  peering_id                    = var.peering_id
  peering_cidr                  = var.peering_cidr
}

##### kms ####

module "kms" {
  source                  = "../../modules/kms"
  env                     = var.env
}

# ####  EKS ####
module "eks" {
  source                        = "../../modules/eks"
  #depends_on                    = [module.vpc, module.kms]
  env                            = var.env
  eks_name                       = var.eks_name
  #cl-role                       = module.iam.eks-cl-role
  #ng-role                       = module.iam.eks-ng-role
  #eks-sg                        = [module.sg.Bastion-SG]
  eks-cl-subnet                 = [module.vpc.Public-Subnet-1,module.vpc.Public-Subnet-2,module.vpc.Private-Subnet-1,module.vpc.Private-Subnet-2]
  eks-ng-subnet                 = [module.vpc.Private-Subnet-4,module.vpc.Private-Subnet-5]
  eks-ng-subnet1                = [module.vpc.Private-Subnet-4,module.vpc.Private-Subnet-5]
  eks-ng-subnet2                = [module.vpc.Private-Subnet-6,module.vpc.Private-Subnet-7]
  ng-lt1                        = var.ng-lt1
  ng-name-app-cluster           = var.ng-name-app-cluster
  kms-arn                       = module.kms.KMS
 #key-pair                      = module.creds.kp
  purpose                       = var.purpose
  eks                           = var.eks
  ng-name                       = var.ng-name
  ng-type                       = var.ng-type
  ng-lt                         = var.ng-lt
  eks-labels                    = var.eks-labels
  elb-waf-policy-name           = var.elb-waf-policy-name
}


module "ec2" {
  source = "../../modules/ec2"
  vpc_id_ec2 = module.vpc.VPC
  subnet_id = module.vpc.Public-Subnet-1
  ami = var.ami
  instance_names=var.instance_names
  instance_count = var.instance_count
  sg_name = var.sg_name
  instance_type = var.instance_type
  key_name = var.key_name
  cidr_ssh = ["10.0.0.0/16"]
}

# ### ECR ### 

 module "ecr" {
     source = "../../modules/ecr"
     ecr-repo = var.ecr-repo
 }

# # ### RDS ### 
  module "rds" {
     source = "../../modules/rds"
     env = var.env
     client = var.client
     vpc = module.vpc.VPC
     instance-class = var.instance-class
     rds-subnet = [module.vpc.DB-Subnet-1,module.vpc.DB-Subnet-2]
     db_cidr = ["10.0.0.0/16"]
     storage-type = var.storage-type
     storage = var.storage
     rds-engine = var.rds-engine
     rds-engine-version = var.rds-engine-version
     db_name = var.db_name
     rds-username = var.rds-username
    rds-family-pg = var.rds-family-pg
     backup_period = var.backup_period
     max-auto-storage = var.max-auto-storage
     rds-performance-ins-retention = var.rds-performance-ins-retention
     db-port = var.db-port
     #rds-db-sg = module.sg.rds-sg
     #rds-password = module.creds.db-pass
     rds-performance-insights = var.rds-performance-insights
     public-access = var.public-access
     encrytion = var.encrytion
     multi_az = var.multi_az
     skip-final-snapshot = var.skip-final-snapshot
  }


# #   # #### Guarduty ####
   module "guarduty" {
     source                  = "../../modules/guarduty"
     client                  = var.client
     guard_duty_enable       = var.guard_duty_enable
     ebs_volumes_enable      = var.ebs_volumes_enable
     s3_logs_enable          = var.s3_logs_enable
     kubernetes_audit_logs_enable  = var.kubernetes_audit_logs_enable
   }



# # ###### Cloudtrail #####
 module "cloudtrail" {
   source                   = "../../modules/cloudtrail"
   depends_on               = [module.kms]
   prefix              = var.prefix
    env                      = var.env
   force_destroy_bucket      = var.force_destroy_bucket
   enable_log_file_validation = var.enable_log_file_validation
   include_global_service_events = var.include_global_service_events
   kms_key_id    =  module.kms.KMS
}


# ###### Config #####
module "config" {
   source                   = "../../modules/config"
   client                   = var.client
   config_rules             = var.config_rules
   #sns_subscription_email   = var.sns_subscription_email
   #config_bucket_name       = var.config_bucket_name
 }




#####  Cloudfront  #####
 module "cloudfront" {
   
   source                        = "../../modules/cloudfront"
   env                           = var.env
   client                        = var.client
   cf-customer                   = module.s3.CF-S3-domain
   cf-admin                      = module.s3.CF-S3-domain
   Retention                     = var.Retention
   customer-domain               = module.s3.CF-S3-domain
   admin-domain                  = module.s3.CF-S3-domain
   #waf-cf                        = module.waf-cf.waf-acl
   #cf-acm                        = var.cf-acm
 }



####WAF
 module "waf" {
   prefix                      = var.prefix
   env                         = var.env
   source                      = "../../modules/waf"
   waf_web_acl                 = var.waf_web_acl
   waf_web_acl_rulesets_common = var.waf_web_acl_rulesets_common
   waf_web_acl_rulesets        = var.waf_web_acl_rulesets
 }


 module "opensearch" {
  os = var.os
  vpc_id = module.vpc.VPC
  subnet_id_os = [module.vpc.Private-Subnet-2,module.vpc.Private-Subnet-1,module.vpc.Private-Subnet-3]
  count = var.os["env"] == "prod" ? 1 : 0
  source   = "../../modules/opensearch"
}


module "s3" {
  source          = "../../modules/s3"
  client          = var.client
  env             = var.env
}

module "jenkins" {
  source         = "../../modules/jenkins"
  depends_on     = [module.vpc]
  env        = var.env
  public_subnet = module.vpc.Public-Subnet-1
  key_pair       = var.key_pair
  vpc_id         = module.vpc.VPC
  instance_type  = var.instance_type_jenkins
  ami_id         = var.ami_id
  volume_type    = var.volume_type
  volume_size    = var.volume_size
}

module "cloudwatch" {
  # count = var.security_services.cloudwatch

  prefix                              = var.prefix
  env                                 = var.env
  source                              = "../../modules/cloudwatch"
  cloudwatch_log_group_name           = var.cloudwatch_log_group_name
  cloudwatch_notification_topic       = var.cloudwatch_notification_topic
  sns_subscription_email              = var.sns_subscription_email
  log_metric_filters                  = var.log_metric_filters
  log_metric_filters_common           = var.log_metric_filters_common
  # s3_buckets                          = local.s3_buckets
  # lambda_functions                    = local.lambda_functions
  # rds_databases                       = local.rds_databases
  best_practices_alarms               = var.best_practices_alarms
  best_practices_alarms_common        = var.best_practices_alarms_common
  # rds_alarms_common                   = var.rds_alarms_common
}


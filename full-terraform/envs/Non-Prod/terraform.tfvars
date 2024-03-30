# #####  Common  #####
region      = "ap-south-1"
env         = "dev"
prefix      = "truemeds"
client      = "truemeds"
Retention   = 90
account     = "749937265741"
purpose     = "dev-Env"
az          = ["ap-south-1a" , "ap-south-1b"]

#####  VPC  #####
cidr = {
    vpc         = "10.10.0.0/16"                    
    DB-Subnet-1 = "10.10.1.0/24"
    DB-Subnet-2 = "10.10.2.0/24"
   
    Private-Subnet-1 = "10.10.3.0/24"
    Private-Subnet-2 = "10.10.4.0/24"
    Private-Subnet-3 = "10.10.8.0/24"
    Private-Subnet-4  = "10.10.128.0/19"
    Private-Subnet-5  = "10.10.32.0/19"
    Private-Subnet-6  = "10.10.64.0/20"
    Private-Subnet-7  = "10.10.80.0/20"
 
    Public-Subnet-1 = "10.10.5.0/24"                 
    Public-Subnet-2 = "10.10.6.0/24"
 
} 
peering_id =  "pcx-01fa03b3012fbf629"
peering_cidr =  "192.168.248.0/21"


####  EC2 ####
instance_count = 3
instance_names = ["dev-jenkins","dev-sonarqube","dev-log-stash"]
ami = ["ami-057752b3f1d6c4d6c","ami-057752b3f1d6c4d6c","ami-057752b3f1d6c4d6c"]
sg_name = "dev_sg"
cidr_ssh = ["10.10.0.0/16"]
instance_type = ["t2.medium","t2.medium","t2.medium"]
key_name = "Dev-key"




#####  EKS  #####
eks =  {
    version       = "1.24"
    desired       = 1
    max           = 2
    min           = 1
    storage       = 20
    ami           = "ami-0c20f7dfb0f206cdb"
}

eks_name = ["dev-warehouse-cluster","dev-app-cluster"]
ng-lt1   = ["dev-app-EKS-Lt"]
ng-name-app-cluster = ["dev-app-EKS-Node-Group"]

ng-name = ["dev-warehouse-EKS-Node-Group","dev-warehouse-EKS-Node-Group2"]

ng-lt = ["dev-warehouse-EKS-Lt","dev-warehouse-EKS-Lt1"]

eks-labels = ["admin","admin"]

ng-type = ["c6a.large"]

elb-waf-policy-name = "dev-elb-waf-policy"




#### RDS###
db_name = ["devwareousedb","devkongdb"]
instance-class = ["db.t4g.medium","db.t3.micro"]
db_cidr = ["10.10.0.0/16"]
storage-type = "gp3"                          
storage = "20"
rds-engine = ["mysql","postgres"]
rds-engine-version = ["8.0.32","14"]
rds-username = ["truemeds_warehouse","truemeds_kong"]
rds-family-pg = ["mysql8.0","postgres14"]          
backup_period = 7
max-auto-storage = "30"                     #storge capacity
rds-performance-insights = true
rds-performance-ins-retention = 7
db-port = ["3306","5432"]                                           
public-access = false
encrytion = false
multi_az = false
skip-final-snapshot = false

####Guarduty
guard_duty_enable = true
ebs_volumes_enable = true
s3_logs_enable = true
kubernetes_audit_logs_enable = true


###ECR
ecr-repo=["dev-csr-svc","dev-customer-svc","dev-doctor-svc","dev-oauth-svc","dev-mixpanel-integration-svc","dev-admin-service","dev-ordermanagement-svc","dev-pharmacist-svc","dev-reports-svc","dev-scheduler-svc","dev-tracking-svc","dev-thirdparty-svc","dev-warehouse-mumbai-svc","dev-marketing-integration-svc","dev-app-csr-svc","dev-app-customer-svc","dev-app-doctor-svc","dev-app-oauth-svc","dev-app-mixpanel-integration-svc","dev-app-admin-service","dev-app-ordermanagement-svc","dev-app-pharmacist-svc","dev-app-reports-svc","dev-app-scheduler-svc","dev-app-tracking-svc","dev-app-thirdparty-svc","dev-app-warehouse-mumbai-svc","dev-app-marketing-integration-svc","dev-app-bot-svc","dev-app-webhook-svc","dev-app-article-svc","dev-app-warehouse-bangalore-svc","dev-app-warehouse-lucknow-svc","dev-app-warehouse-delhi-svc","dev-app-warehouse-kolkata-svc"]

# #### Cloudtrail #####
enable_log_file_validation = true
include_global_service_events = true
force_destroy_bucket = true
# bucket_name = "matchlog_nonprod"


###os
os = {
    env = "dev"
    vpc_name = "dev-vpc"
    domain_name = "truemeds-os"
    engine_version = "OpenSearch_2.5"
    user_name = "truemeds"
    user_password = "Truemeds#01"
    auto_tune_options = {
        desired_state = "DISABLED"
        rollback_on_disable = "NO_ROLLBACK"
    }
    cluster_config = {
        instance_type = "r6g.large.search"
        dedicated_master_enabled = true
        zone_awareness_enabled = true
        availability_zone_count = 3
        dedicated_master_count = 3
        instance_count = 3
    }
    ebs_options = {
        ebs_enabled = true
        volume_size = 10
        volume_type = "gp3"
    }
    sg = {
        sg_name = "os-sg"
        ingress_sg_name =  "logstash-sg"
        sg_ingress_cidr_block = "10.10.0.0/16"
    }   
}




####
app_bucket_name="dev-truemeds-fronted.com"
alias_domain_content_cdn = "cdn-dev-us.cachy.com"

# #####  Common  #####
region      = "ap-south-1"
env         = "prod"
prefix      = "truemeds"
client      = "truemeds"
Retention   = 90
account     = "506905091042"
purpose     = "prod-Env"
az          = ["ap-south-1a" , "ap-south-1b","ap-south-1c"]

#####  VPC  #####
cidr = {
    vpc         = "10.0.0.0/16"                    
    DB-Subnet-1 = "10.0.1.0/24"
    DB-Subnet-2 = "10.0.2.0/24"
   
    Private-Subnet-1 = "10.0.3.0/24"
    Private-Subnet-2 = "10.0.4.0/24"
    Private-Subnet-3 = "10.0.5.0/24"
    Private-Subnet-4  = "10.0.128.0/19"
    Private-Subnet-5  = "10.0.32.0/19"
    Private-Subnet-6  = "10.0.64.0/20"
    Private-Subnet-7  = "10.0.80.0/20"

 
    Public-Subnet-1 = "10.0.6.0/24"                 
    Public-Subnet-2 = "10.0.7.0/24"
 
} 
peering_id = "pcx-053ad413be19b05cf"
peering_cidr = "192.168.248.0/21"


####  EC2 ####
instance_count = 3
instance_names = ["prod-sonarqube","prod-openvpn","prod-log-stash"]
ami = ["ami-057752b3f1d6c4d6c","ami-0fd505d7f13496375","ami-057752b3f1d6c4d6c"]
sg_name = "prod_sg"
key_name = "Prod-key"
instance_type = ["t2.medium","t2.micro","t2.medium"]



#####  EKS  #####
eks =  {
    version       = "1.24"
    desired       = 1
    max           = 2
    min           = 1
    storage       = 20
    ami           = "ami-0c20f7dfb0f206cdb"
}

eks_name = ["prod-warehouse-cluster","prod-app-cluster"]

ng-name = ["prod-warehouse1-EKS-Node-Group","prod-warehouse2-EKS-Node-Group2","prod-warehouse3-EKS-Node-Group3","prod-warehouse4-EKS-Node-Group4","prod-warehouse5-EKS-Node-Group5","prod-warehouse1-EKS-Node-Group1","prod-warehouse2-EKS-Node-Group2"]

ng-name-app-cluster = ["prod-app-EKS-Node-Group","prod-app-eks-Node-Group"]
ng-lt1 = ["prod-app-eks-lt","prod-app-EKS-lt"]

ng-lt = ["prod-warehouse-EKS-Lt","prod-warehouse-EKS-Lt1","prod-warehouse-EKS-Lt2","prod-warehouse-EKS-Lt3","prod-warehouse-EKS-Lt4","prod-warehouse-EKS-Lt5","prod-warehouse-EKS-Lt6"]

eks-labels = ["admin","admin","admin","admin","admin","admin","admin"]

ng-type = ["c6a.large"]

elb-waf-policy-name = "prod-elb-waf-policy"





# #### Jeknins ####
instance_type_jenkins = "t3a.2xlarge"
ami_id = "ami-074dc0a6f6c764218"
volume_type = "gp3"
volume_size = 300
key_pair      = "Prod-key"


#### RDS###
db_name = ["prodkongdb","prodwarehousedb"]
instance-class = ["db.t3.micro","db.t4g.medium"]
storage-type = "gp3"                          
storage = "20"
rds-engine = ["postgres","mysql"]
rds-engine-version = ["14","8.0.32"]
rds-username = ["truemeds_kong","truemeds_prodadmin"]
rds-family-pg = ["postgres14","mysql8.0"]          
backup_period = 7
max-auto-storage = "30"                     #storge capacity
rds-performance-insights = true
rds-performance-ins-retention = 7
db-port = ["5432","3306"]                                           
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
ecr-repo=["warehouse1-csr-svc","warehouse1-customer-svc","warehouse1-doctor-svc","warehouse1-oauth-svc","warehouse1-mixpanel-integration-svc","warehouse1-admin-svc","warehouse1-ordermanagement-svc","warehouse1-pharmacist-svc","warehouse1-tracking-svc","warehouse1-thirdparty-svc","warehouse1-warehouse-mumbai-svc","warehouse1-marketing-integration-svc","warehouse2-csr-svc","warehouse2-customer-svc","warehouse2-doctor-svc","warehouse2-oauth-svc","warehouse2-mixpanel-integration-svc","warehouse2-admin-svc","warehouse2-ordermanagement-svc","warehouse2-pharmacist-svc","warehouse2-tracking-svc","warehouse2-thirdparty-svc","warehouse2-warehouse-kolkata-svc","warehouse2-marketing-integration-svc","warehouse3-csr-svc","warehouse3-customer-svc","warehouse3-doctor-svc","warehouse3-oauth-svc","warehouse3-mixpanel-integration-svc","warehouse3-admin-svc","warehouse3-ordermanagement-svc","warehouse3-pharmacist-svc","warehouse3-tracking-svc","warehouse3-thirdparty-svc","warehouse3-warehouse-delhi-svc","warehouse3-marketing-integration-svc","warehouse4-csr-svc","warehouse4-customer-svc","warehouse4-doctor-svc","warehouse4-oauth-svc","warehouse4-mixpanel-integration-svc","warehouse4-admin-svc","warehouse4-ordermanagement-svc","warehouse4-pharmacist-svc","warehouse4-tracking-svc","warehouse4-thirdparty-svc","warehouse4-warehouse-bangalore-svc","warehouse4-marketing-integration-svc","warehouse5-csr-svc","warehouse5-customer-svc","warehouse5-doctor-svc","warehouse5-oauth-svc","warehouse5-mixpanel-integration-svc","warehouse5-admin-svc","warehouse5-ordermanagement-svc","warehouse5-pharmacist-svc","warehouse5-tracking-svc","warehouse5-thirdparty-svc","warehouse5-warehouse-lucknow-svc","warehouse5-marketing-integration-svc","app-csr-svc","app-customer-svc","app-doctor-svc","app-oauth-svc","app-mixpanel-integration-svc","app-admin-service","app-ordermanagement-svc","app-pharmacist-svc","app-reports-svc","app-scheduler-svc","app-tracking-svc","app-thirdparty-svc","app-warehouse-mumbai-svc","app-marketing-integration-svc","app-bot-svc","app-webhook-svc","app-article-svc","app-warehouse-bangalore-svc","app-warehouse-lucknow-svc","app-warehouse-delhi-svc","app-warehouse-kolkata-svc"]
# #### Cloudtrail #####
enable_log_file_validation = true
include_global_service_events = true
force_destroy_bucket = true
# bucket_name = "matchlog_nonprod"


###os
os = {
    env = "prod"
    vpc_name = "prod-vpc"
    domain_name = "truemeds-prod-os"
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
        sg_ingress_cidr_block = "10.0.0.0/16"
    }   
}




####
app_bucket_name="prod-truemeds-fronted.com"
alias_domain_content_cdn = "cdn-prod-us.cachy.com"

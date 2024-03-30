###  Common  #####
variable "client" {
  description = "Name & Envionment of the client"
  type = string
}

variable "prefix"{}

variable "env"{}
variable "region" {
  description = "The Region of Operation"
  type = string
}
variable "Retention" {
  description = "Retentention Period for VPC Flow logs"
  type = number
}
variable "purpose" {
  description = "Purpose Tag for the Instance"
  type = string
}
variable "account" {
  description = "Account ID"
  type = string
}
# variable "az" {
#   description = "Availability zones for the Resource"
#   type = list(string)
# }

#####  VPC  #####
variable "cidr" {
  description = "CIDR for VPC and Subnets"  
  type = object({
    vpc                 = string,
    Public-Subnet-1     = string,
    Public-Subnet-2     = string,
    #Public-Subnet-3     = string,
    Private-Subnet-1    = string,
    Private-Subnet-2    = string,
    #Private-Subnet-3    = string,
    Private-Subnet-3    = string,
    Private-Subnet-4    = string,
    Private-Subnet-5    = string,
    Private-Subnet-6    = string,
    Private-Subnet-7    = string,
    DB-Subnet-1         = string,
    DB-Subnet-2         = string,
    #DB-Subnet-3         = string
  })
}
variable"peering_id"{}
variable"peering_cidr"{}

####EC2
variable "instance_count"{}
variable "instance_type"{}
variable "key_name"{}



variable "instance_names" {
  description = "Names for the EC2 instances"
  type        = list(string)
  # Update with your desired instance names
}

variable "ami" {}
variable"sg_name"{}
variable"cidr_ssh"{}


#### kms ####
#variable "client" {}


### ECR ###

variable "ecr-repo" {
  type = list(string)
}

#####  EKS  #####
variable "eks"{
  description = "Details of LT  Server"
  type = object({
    version        = string,
    desired        = number,
    max            = number,
    min            = number,
    storage        = number,
    ami            = string,
  })
}

variable "eks_name" {}
variable "ng-name" {
}
variable "ng-type" {
}
variable "ng-lt" {
}

variable "eks-auth-labels" {
  description = "eks labels"
  type = list(string)
  default = ["admin"]
}



variable "eks-labels" {
  description = "eks labels"
  type = list(string)
  default = ["admin"]
}

variable "elb-waf-policy-name" {}


# # variable "vpc" {}
###RDS
#variable "env" {}
#variable "client" {}
variable "instance-class" {}
#variable "rds-subnet" {}
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
variable"db_cidr"{}
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
#variable "vpc" {}





# ##### GuarDuty #####
variable "guard_duty_enable" {}
variable "ebs_volumes_enable" {}
variable "s3_logs_enable" {}
variable "kubernetes_audit_logs_enable" {}


# ##### Cloudtrail #####

variable "force_destroy_bucket" {}
variable "include_global_service_events" {}
variable "enable_log_file_validation" {}
#variable "bucket_name" {}


/*
# ##### Config ######
variable "config_rules" {}
variable "sns_subscription_email" {}
variable "config_bucket_name" {}
*/


# ######Cloud Watch ####



 variable "sns_subscription_email" {
  default = "pratik.falke@truemeds.in"
 }




##CloudWatch#####

variable "cloudwatch_log_group_name" {
   type    = string
   default = "security-events"
 }

 variable "cloudwatch_notification_topic" {
   type    = string
   default = "cloudwatch-alarms"
 }


 variable "log_metric_filters" {
   type = map(object({
     pattern = string
   }))

   default = {
     "AuthorizationFailureCount" = {
       pattern = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
     },
     "BucketPolicyChangesEventCount" = {
       pattern = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
     },
     "CMKDisableDeleteEventCount" = {
       pattern = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
     },
     "CloudTrailEventCount" = {
       pattern = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
     },
     "ConfigConfigurationChangesEventCount" = {
       pattern = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
     },
     "ConsoleLoginWithoutMFAEventCount" = {
       pattern = "{ $.eventName=\"ConsoleLogin\" && $.additionalEventData.MFAUsed !=\"Yes\" }"
     },
     "ConsoleSignInFailureCount" = {
       pattern = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
     },
     "EC2InstanceEventCount" = {
       pattern = "{ ($.eventName = RunInstances) || ($.eventName = RebootInstances) || ($.eventName = StartInstances) || ($.eventName = StopInstances) || ($.eventName = TerminateInstances) }"
     },
     "EC2LargeInstanceEventCount" = {
       pattern = "{ (($.eventName = RunInstances) || ($.eventName = RebootInstances) || ($.eventName = StartInstances) || ($.eventName = StopInstances) || ($.eventName = TerminateInstances)) && (($.requestParameters.instanceType = *.32xlarge) || ($.requestParameters.instanceType = *.24xlarge) || ($.requestParameters.instanceType = *.18xlarge) || ($.requestParameters.instanceType = *.16xlarge) || ($.requestParameters.instanceType = *.12xlarge) || ($.requestParameters.instanceType = *.10xlarge) || ($.requestParameters.instanceType = *.9xlarge) || ($.requestParameters.instanceType = *.8xlarge) || ($.requestParameters.instanceType = *.4xlarge)) }"
     },
     "GatewayEventCount" = {
       pattern = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
     },
     "IAMPolicyEventCount" = {
       pattern = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
     },
     "NetworkAclEventCount" = {
       pattern = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
     },
     "RootLoginEventCount" = {
       pattern = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
     },
     "RouteTableChangesEventCount" = {
       pattern = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
     },
     "SecurityGroupEventCount" = {
       pattern = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"
     },
     "VpcEventCount" = {
       pattern = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
     }
   }
 }

 variable "log_metric_filters_common" {
   type = object({
     namespace = string,
     value     = string
   })

   default = {
     namespace = "LogMetrics",
     value     = "1"
   }
 }

###WAF

 variable "waf_web_acl" {
   type = object({
     name                       = string
     description                = string
     scope                      = string
     cloudwatch_metrics_enabled = bool
     sampled_requests_enabled   = bool
   })

   default = {
     name                       = "waf-web-acl"
     description                = "AWS WAF ACL with necessary AWS managed rule groups",
     scope                      = "REGIONAL"
     cloudwatch_metrics_enabled = true
     sampled_requests_enabled   = true
   }
 }

 variable "waf_web_acl_rulesets_common" {
   type = object({
     vendor_name                = string
     cloudwatch_metrics_enabled = bool
     sampled_requests_enabled   = bool
   })

   default = {
     vendor_name                = "AWS"
     cloudwatch_metrics_enabled = false
     sampled_requests_enabled   = false
   }
 }

 variable "waf_web_acl_rulesets" {
   type = list(object({
     ruleset_name  = string,
     friendly_name = string,
     priority      = number
   }))

   default = [
     {
       ruleset_name  = "AWSManagedRulesAdminProtectionRuleSet"
       friendly_name = "AWSManagedRulesAdminProtectionRuleSet"
       priority      = 0
     },
     {
       ruleset_name  = "AWSManagedRulesAmazonIpReputationList"
       friendly_name = "AWSManagedRulesAmazonIpReputationList"
       priority      = 1
     },
     {
       ruleset_name  = "AWSManagedRulesAnonymousIpList"
       friendly_name = "AWSManagedRulesAnonymousIpList"
       priority      = 2
     },
     {
       ruleset_name  = "AWSManagedRulesKnownBadInputsRuleSet"
       friendly_name = "AWSManagedRulesKnownBadInputsRuleSet"
       priority      = 3
     },
     {
       ruleset_name  = "AWSManagedRulesLinuxRuleSet"
       friendly_name = "AWSManagedRulesLinuxRuleSet"
       priority      = 4
     },
     {
       ruleset_name  = "AWSManagedRulesCommonRuleSet"
       friendly_name = "AWSManagedRulesCommonRuleSet"
       priority      = 5
     }
   ]
 }

 ####
 variable "config_rules" {
  default = {
    "CheckForEncryptedVolumes" = {
      description = "Checks whether EBS volumes that are in an attached state are encrypted."
      compliance_resource_types = [
        "AWS::EC2::Volume"
      ]
      owner                       = "AWS"
      source_identifier           = "ENCRYPTED_VOLUMES"
      input_parameters            = "{}"
      maximum_execution_frequency = null
    },
    "CheckForRdsEncryption" = {
      description = "Checks whether storage encryption is enabled for your RDS DB instances."
      compliance_resource_types = [
        "AWS::RDS::DBInstance"
      ]
      owner                       = "AWS"
      source_identifier           = "RDS_STORAGE_ENCRYPTED"
      input_parameters            = "{}"
      maximum_execution_frequency = null
    },
    "CheckForRestrictedCommonPortsPolicy" = {
      description = "Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
      compliance_resource_types = [
        "AWS::EC2::SecurityGroup"
      ]
      owner                       = "AWS"
      source_identifier           = "RESTRICTED_INCOMING_TRAFFIC"
      input_parameters            = "{\"blockedPort3\":\"3389\",\"blockedPort4\":\"3306\",\"blockedPort1\":\"20\",\"blockedPort2\":\"21\",\"blockedPort5\":\"4333\"}"
      maximum_execution_frequency = null
    },
    "CheckForRestrictedSshPolicy" = {
      description = "Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."
      compliance_resource_types = [
        "AWS::EC2::SecurityGroup"
      ]
      owner                       = "AWS"
      source_identifier           = "INCOMING_SSH_DISABLED"
      input_parameters            = null
      maximum_execution_frequency = null
    },
    "CheckForS3PublicRead" = {
      description = "Checks that your S3 buckets do not allow public read access. If an S3 bucket policy or bucket ACL allows public read access, the bucket is noncompliant."
      compliance_resource_types = [
        "AWS::S3::Bucket"
      ]
      owner                       = "AWS"
      source_identifier           = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
      input_parameters            = null
      maximum_execution_frequency = null
    },
    "CheckForS3PublicWrite" = {
      description = "Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant."
      compliance_resource_types = [
        "AWS::S3::Bucket"
      ]
      owner                       = "AWS"
      source_identifier           = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
      input_parameters            = null
      maximum_execution_frequency = null
    },
    "CheckForIamPasswordPolicy" = {
      description                 = "Checks whether the account password policy for IAM users meets the specified requirements."
      compliance_resource_types   = null
      owner                       = "AWS"
      source_identifier           = "IAM_PASSWORD_POLICY"
      input_parameters            = "{\"MinimumPasswordLength\":\"12\",\"RequireLowercaseCharacters\":\"true\",\"RequireNumbers\":\"true\",\"PasswordReusePrevention\":\"6\",\"MaxPasswordAge\":\"90\",\"RequireUppercaseCharacters\":\"true\",\"RequireSymbols\":\"true\"}"
      maximum_execution_frequency = "TwentyFour_Hours"
    },
    "CheckForRootMfa" = {
      description                 = "Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."
      compliance_resource_types   = null
      owner                       = "AWS"
      source_identifier           = "ROOT_ACCOUNT_MFA_ENABLED"
      input_parameters            = null
      maximum_execution_frequency = "TwentyFour_Hours"
    }
  }
}


variable "os" {}


####cdn

variable "app_bucket_name" {}




variable "best_practices_alarms_common" {
  type = object({
    actions_enabled     = bool,
    namespace           = string,
    statistic           = string,
    dimensions          = map(string),
    period              = number,
    evaluation_periods  = number
    threshold           = map(string)
    comparison_operator = string
    treat_missing_data  = string
  })

  default = {
    actions_enabled    = true,
    namespace          = "LogMetrics",
    statistic          = "Sum",
    dimensions         = {},
    period             = 300,
    evaluation_periods = 1,
    threshold = {
      "Other"                           = 1,
      "CloudTrailConsoleSignInFailures" = 3
    }
    comparison_operator = "GreaterThanOrEqualToThreshold",
    treat_missing_data  = "notBreaching"
  }
}

variable "best_practices_alarms" {
  type = map(object({
    alarm_description = string
    metric_name       = string
  }))

  default = {
    "BucketPolicyChanges" = {
      alarm_description = "Alarms when S3 bucket policy is changed."
      metric_name       = "BucketPolicyChangesEventCount"
    },
    "CMKDisableDelete" = {
      alarm_description = "Alarms when the CMKDisableDelete is disabled or scheduled for deletion."
      metric_name       = "CMKDisableDeleteEventCount"
    },
    "CloudTrailAuthorizationFailures" = {
      alarm_description = "Alarms when an unauthorized API call is made."
      metric_name       = "AuthorizationFailureCount"
    },
    "CloudTrailChanges" = {
      alarm_description = "Alarms when an API call is made to create, update or delete a CloudTrail trail, or to start or stop logging to a trail."
      metric_name       = "CloudTrailEventCount"
    },
    "CloudTrailConsoleSignInFailures" = {
      alarm_description = "Alarms when an unauthenticated API call is made to sign into the console."
      metric_name       = "ConsoleSignInFailureCount"
    },
    "CloudTrailEC2InstanceChanges" = {
      alarm_description = "Alarms when an API call is made to create, terminate, start, stop or reboot an EC2 instance."
      metric_name       = "EC2InstanceEventCount"
    },
    "CloudTrailEC2LargeInstanceChanges" = {
      alarm_description = "Alarms when an API call is made to create, terminate, start, stop or reboot a 4x, 8x, 9x, 10x, 12x, 16x, 18x, 24x, 32x-large EC2 instance."
      metric_name       = "EC2LargeInstanceEventCount"
    },
    "CloudTrailGatewayChanges" = {
      alarm_description = "Alarms when an API call is made to create, update or delete a Customer or Internet Gateway."
      metric_name       = "GatewayEventCount"
    },
    "CloudTrailNetworkAclChanges" = {
      alarm_description = "Alarms when an API call is made to create, update or delete a Network ACL."
      metric_name       = "NetworkAclEventCount"
    },
    "CloudTrailSecurityGroupChanges" = {
      alarm_description = "Alarms when an API call is made to create, update or delete a Security Group."
      metric_name       = "SecurityGroupEventCount"
    },
    "CloudTrailVpcChanges" = {
      alarm_description = "Alarms when an API call is made to create, update or delete a VPC, VPC peering connection or VPC connection to classic."
      metric_name       = "VpcEventCount"
    } 
    "ConfigConfigurationChanges" = {
      alarm_description = "Alarms when AWS Config Configuration is changed."
      metric_name       = "ConfigConfigurationChangesEventCount"
    },
    "ConsoleLoginWithoutMFA" = {
      alarm_description = "Alarms when the user logs in without mfa."
      metric_name       = "ConsoleLoginWithoutMFAEventCount"
    },
    "IAMPolicyChanges" = {
      alarm_description = "Alarms when IAM policy changs are made."
      metric_name       = "IAMPolicyEventCount"
    },
    "RootLogin" = {
      alarm_description = "Alarms when the root user logs in."
      metric_name       = "RootLoginEventCount"
    },
    "RouteTableChanges" = {
      alarm_description = "Alarms when route table configuration is changed."
      metric_name       = "RouteTableChangesEventCount"
    }
  }
}

variable "ng-lt1"{}

variable "ng-name-app-cluster"{}












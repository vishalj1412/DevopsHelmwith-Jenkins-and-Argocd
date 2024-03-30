### AWS OpenSearch ### 

resource "aws_opensearch_domain" "opensearch" {
    domain_name = lower("${var.os["env"]}-${var.os["domain_name"]}")
    engine_version = var.os["engine_version"]
    node_to_node_encryption {
      enabled = true
    }
    encrypt_at_rest {
      enabled = true
    }
    domain_endpoint_options {
      enforce_https = true
      tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
    }
    advanced_security_options {
      enabled = true
      internal_user_database_enabled = true
      master_user_options {
        master_user_name = var.os["user_name"]
        master_user_password = var.os["user_password"]
      }
    }
    auto_tune_options {
     desired_state = var.os.auto_tune_options["desired_state"]
     rollback_on_disable = var.os.auto_tune_options["rollback_on_disable"]
    }
    cluster_config{
        instance_type = var.os.cluster_config["instance_type"]
        dedicated_master_enabled = var.os.cluster_config["dedicated_master_enabled"]
        zone_awareness_enabled = var.os.cluster_config["zone_awareness_enabled"] 
        instance_count = var.os.cluster_config["instance_count"]
        dedicated_master_type = var.os.cluster_config["instance_type"]
        dedicated_master_count= var.os.cluster_config["dedicated_master_count"]
        zone_awareness_config{
        availability_zone_count = var.os.cluster_config["availability_zone_count"]
      }
    }
    
    ebs_options{
        ebs_enabled = var.os.ebs_options["ebs_enabled"]
        volume_size = var.os.ebs_options["volume_size"]
        volume_type = var.os.ebs_options["volume_type"]
    }

    vpc_options{
    security_group_ids  = [aws_security_group.os-sg.id]
    subnet_ids          = var.subnet_id_os
  }
    
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.os["env"]}-${var.os["domain_name"]}/*"
    }
  ]
}
POLICY

   tags       = {
    Name = "${var.os["env"]}-${var.os["domain_name"]}"
  }

  lifecycle {
    ignore_changes = [
      ebs_options
    ]
  }
}

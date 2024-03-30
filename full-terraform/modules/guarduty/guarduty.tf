resource "aws_guardduty_detector" "GaurdDutyDetector" {
  enable = "${var.guard_duty_enable}"
  datasources {
    s3_logs {
      enable = "${var.s3_logs_enable}"
    }
    kubernetes {
      audit_logs {
        enable = "${var.kubernetes_audit_logs_enable}"
      }
    }
    malware_protection {
     scan_ec2_instance_with_findings {
       ebs_volumes {
         enable = "${var.ebs_volumes_enable}"
       }
     }
    }
  }
}

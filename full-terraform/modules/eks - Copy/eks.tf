#################### Cluster Auth###############


resource "aws_eks_cluster" "eks-cl" {
  # Remove the count argument
  name     = local.cluster_name
  role_arn = aws_iam_role.eks-cl-role.arn
  version  = var.eks.version

  enabled_cluster_log_types = ["audit", "api", "controllerManager", "scheduler", "authenticator"]

  vpc_config {
    subnet_ids               = var.eks-cl-subnet
    endpoint_private_access  = true
    endpoint_public_access   = false
  }


  tags = {
    Name = "${var.env}-cluster"
  }
}

###################### Node Group #######################

resource "aws_eks_node_group" "eks-node-gr" {
  depends_on = [aws_launch_template.ng-lt]
  count = length(var.ng-name)
  cluster_name    = "${aws_eks_cluster.eks-cl.name}"
  node_group_name = "${var.ng-name[count.index]}"
  force_update_version = false
  node_role_arn   = aws_iam_role.eks-ng-role.arn
  subnet_ids      = count.index == 0 ? var.eks-ng-subnet : var.eks-ng-subnet1
  instance_types  = var.ng-type  
  capacity_type   = var.capacity_type
  scaling_config {
    desired_size = var.eks.desired
    max_size     = var.eks.max
    min_size     = var.eks.min
  }

  labels = {
    node = var.eks-labels[count.index]
  }

  launch_template {
   name = "${var.ng-lt[count.index]}"
   version = "$Latest"
  }
  tags = {
    Name         = "${var.ng-name[count.index]}"
  }
}

resource "aws_launch_template" "ng-lt" {
  count = length(var.ng-lt)
  name = "${var.ng-lt[count.index]}"
  disable_api_termination = false
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted = true
      volume_size = var.eks.storage
      volume_type = "gp3"
    }
  }
  image_id = var.eks.ami
  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
/etc/eks/bootstrap.sh ${aws_eks_cluster.eks-cl.name}
timedatectl set-timezone Asia/Kolkata 
--==MYBOUNDARY==--\
  EOF
  )
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-EKS-Nodes"
      Purpose = var.purpose
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${var.env}-EKS-Nodes"
    }
  }
}

resource "aws_eks_node_group" "eks-node-gr1" {
  depends_on = [aws_launch_template.ng-lt1]
  count = length(var.ng-name-app-cluster)
  cluster_name    = "${aws_eks_cluster.eks-cl1.name}"
  node_group_name = "${var.ng-name-app-cluster[count.index]}"
  force_update_version = false
  node_role_arn   = aws_iam_role.eks-ng-role.arn
  subnet_ids      = var.eks-ng-subnet2
  instance_types  = var.ng-type  
  scaling_config {
    desired_size = var.eks.desired
    max_size     = var.eks.max
    min_size     = var.eks.min
  }

  labels = {
    node = var.eks-labels[count.index]
  }

  launch_template {
   name = "${var.ng-lt1[count.index]}"
   version = "$Latest"
  }
  tags = {
    Name         = "${var.ng-name-app-cluster[count.index]}"
  }
 
}

resource "aws_launch_template" "ng-lt1" {
  count = length(var.ng-lt1)
  name = "${var.ng-lt1[count.index]}"
  disable_api_termination = false
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      encrypted = true
      kms_key_id = var.kms-arn
      volume_size = var.eks.storage
      volume_type = "gp3"
    }
  }
  image_id = var.eks.ami
  #instance_type = var.eks.instance-type
  #key_name = var.key-pair
  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
/etc/eks/bootstrap.sh ${aws_eks_cluster.eks-cl1.name}
timedatectl set-timezone Asia/Kolkata
--==MYBOUNDARY==--\
  EOF
  )
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-EKS-Nodes"
      Purpose = var.purpose
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${var.env}-EKS-Nodes"
    }
  }
}
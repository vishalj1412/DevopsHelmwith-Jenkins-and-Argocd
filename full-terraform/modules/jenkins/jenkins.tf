resource "aws_instance" "jenkins-server" {
  ami = var.ami_id
  subnet_id = var.public_subnet
  instance_type = var.instance_type
  key_name = var.key_pair
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  iam_instance_profile = aws_iam_instance_profile.EC2-S3-SSM-CW-Profile.name


  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = false
  }
  user_data = <<EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install wget
              sudo amazon-linux-extras install java-openjdk11
              sudo amazon-linux-extras install epel -y
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo yum install jenkins -y
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
            EOF
  tags = {
    Name = "${var.env}-Jenkins"
  }
}
resource "aws_eip" "jenkins-eip" {
  instance = aws_instance.jenkins-server.id
  vpc      = true

  tags = {
    Name = "${var.env}-Jenkins-EIP"
  }
}

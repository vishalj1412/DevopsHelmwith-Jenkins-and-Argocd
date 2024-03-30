#### ECR ###

resource "aws_ecr_repository" "repo" {
    count = length(var.ecr-repo)
    name = "${var.ecr-repo[count.index]}"
    encryption_configuration {
      encryption_type = "AES256"
    }
    image_scanning_configuration {
     scan_on_push = true
    }
}

### ECR LifeCycle Policy ###

resource "aws_ecr_lifecycle_policy" "lifecycle" {  
  count = length(var.ecr-repo)
  repository = "${aws_ecr_repository.repo[count.index].name}"
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
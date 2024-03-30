terraform {
    backend "s3" {
    bucket = "truemeds-dev-terraform-statefile-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
 }
}
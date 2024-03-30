terraform {
    backend "s3" {
    bucket = "prod-tm-tfstatefile-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
 }
}
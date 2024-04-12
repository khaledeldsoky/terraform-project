terraform {
  backend "s3" {
    bucket = "khaled-project1-s31"
    key    = "terraform-project-1.tfstate"
    region = "us-east-1"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.51.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "qangelinetf"
    key    = "tf"
    region = "us-east-1"
  }
}
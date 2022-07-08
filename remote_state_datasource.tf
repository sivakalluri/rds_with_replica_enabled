data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "dr-dev-state-file-bucket-20220708060736188100000001"
    key    = "dev/dr-vpc-in-two-regions/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc_region2" {
  backend = "s3"
  config = {
    bucket = "dr-dev-state-file-bucket-20220708060736188100000001"
    key    = "dev/dr-vpc-in-two-regions/terraform.tfstate"
    region = "us-east-1"
  }
}


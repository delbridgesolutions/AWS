terraform {
  backend "s3" {
    bucket = "tf-remote-state"
    # key            = "ops-manager/projects/terraform.tfstate"
    key            = "ops-manager/commits/delbridge/fchacon/terraform.tfstate"
    region         = "cn-northwest-1"
    dynamodb_table = "terraform-lock"
  }
}

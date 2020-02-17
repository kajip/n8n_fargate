/** 基本定義 */

// Remote Backend
terraform {
  required_version = "0.12.6"
}

// AWSプロバイダ
provider "aws" {
  version = "2.49.0"
  region  = var.default_region

  assume_role {
    role_arn = "arn:aws:iam::256776926316:role/OrganizationAccountAccessRole"
  }
}

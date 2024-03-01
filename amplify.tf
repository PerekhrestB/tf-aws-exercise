terraform {
  cloud {
    organization = "bp-assignment"

    workspaces {
      name = "bp-tf-assignment"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_amplify_app" "GettingStartedTf" {
  name       = "GettingStartedTf"
  repository = "https://github.com/PerekhrestB/tf-aws-exercise"
}


provider "google" {
  project = "your-gcp-project-id"
  region  = "your-gcp-region"
}

provider "aws" {
  region = "your-aws-region"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.1"
    }
  }
}

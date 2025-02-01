variable "config" {
  type = object({
    aws_access_key_id     = string
    aws_secret_access_key = string
    aws_s3_bucket         = string
    gcp_project_id        = string
    gcs_bucket_name       = string
    region                = string
    location              = string
  })
  default = {
    aws_access_key_id     = "AKIA5SOY6"
    aws_secret_access_key = "2VnPibyqypUyr"
    aws_s3_bucket         = "application-gcp"
    gcp_project_id        = "vm-group-448915"
    gcs_bucket_name       = "application-aws"
    region                = "us-east-1"
    location              = "us"
  }
}
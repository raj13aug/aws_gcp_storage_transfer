variable "config" {
  type = object({
    aws_access_key_id     = string
    aws_secret_access_key = string
    aws_s3_bucket         = string
    gcp_project_id        = string
    gcs_bucket_name       = string
  })
  default = {
    aws_access_key_id     = "John Doe"
    aws_secret_access_key = "vvv"
    aws_s3_bucket         = "true"
    gcp_project_id        = "vm-group-448915"
    gcs_bucket_name       = "application-aws"
  }
}
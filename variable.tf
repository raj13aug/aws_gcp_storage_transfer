variable "config" {
  type = object({
    aws_access_key_id     = string
    aws_secret_access_key = string
    aws_s3_bucket         = string
    gcp_project_id        = string
    gcs_bucket_name       = string
    region                = string
  })
  default = {
    aws_access_key_id     = "AKIA5SOY666M2"
    aws_secret_access_key = "2VnPibyqypUyrI48ef5NazfXHoHs2cvi"
    aws_s3_bucket         = "true"
    gcp_project_id        = "vm-group-448915"
    gcs_bucket_name       = "application-aws"
    region                = "us-east-1"
  }
}
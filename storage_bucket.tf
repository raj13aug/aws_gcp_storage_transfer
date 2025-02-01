resource "google_project_service" "compute" {
  project = var.config.gcp_project_id
  service = "storagetransfer.googleapis.com"
}


# resource "google_service_account" "transfer_account" {
#   account_id   = "transfer-service-account"
#   display_name = "Transfer Service Account"
# }

# resource "google_project_iam_member" "storage_transfer_service" {
#   project = var.config.gcp_project_id
#   role    = "roles/storage.admin"
#   member  = "serviceAccount:${google_service_account.transfer_account.email}"
# }

resource "google_storage_transfer_job" "s3_to_gcs_transfer" {
  # name        = "s3_to_gcs_transfer_cloudroot7_2025"
  description = "Transfer job from S3 to GCS"

  project = var.config.gcp_project_id

  status = "ENABLED"

  schedule {
    schedule_start_date {
      year  = 2025
      month = 1
      day   = 30
    }
    schedule_end_date {
      year  = 2025
      month = 12
      day   = 31
    }
    start_time_of_day {
      hours   = 12
      minutes = 0
      seconds = 0
      nanos   = 0
    }
  }

  transfer_spec {
    object_conditions {
      max_time_elapsed_since_last_modification = "600s"
      exclude_prefixes = [
        "requests.gz",
      ]
    }
    transfer_options {
      delete_objects_unique_in_sink              = false
      overwrite_objects_already_existing_in_sink = true
    }
    aws_s3_data_source {
      bucket_name = var.config.aws_s3_bucket
      aws_access_key {
        access_key_id     = var.config.aws_access_key_id
        secret_access_key = var.config.aws_secret_access_key
      }
    }
    gcs_data_sink {
      bucket_name = var.config.gcs_bucket_name
      path        = "/"
    }
  }
}
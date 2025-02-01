resource "google_project_service" "compute" {
  project = var.config.gcp_project_id
  service = "storagetransfer.googleapis.com"
}

resource "google_storage_bucket" "target" {
  name          = var.config.gcs_bucket_name
  location      = "US"
  force_destroy = true
}

data "google_storage_transfer_project_service_account" "project_service_account" {
  project = var.config.gcp_project_id
}

resource "google_storage_bucket_iam_member" "storage_bucket_iam_member" {
  bucket = var.config.gcs_bucket_name
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.project_service_account.email}"
}

resource "google_storage_transfer_job" "s3_to_gcs_transfer" {
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
      bucket_name = google_storage_bucket.target.name
    }
  }
}
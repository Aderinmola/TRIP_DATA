# Bucket
resource "google_storage_bucket" "bucket-from-terraform-datat" {
  name          = "bucket-from-terraform-datat"
  location      = "us-central1"
  storage_class = "STANDARD"
  labels = {
    "key1" = "value1"
    "key2" = "value2"
  }
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "photo" {
  name   = "random_photo"
  bucket = google_storage_bucket.bucket-from-terraform-datat.name
  source = "aws_glue.jpg"
}

# big query 
resource "google_bigquery_dataset" "bd_tf" {
  dataset_id                  = "mydataset_tf"
  friendly_name               = "example_dataset"
  description                 = "This is Bigquery dataset from Terraform Script"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "table_tf" {
  dataset_id = google_bigquery_dataset.bd_tf.dataset_id
  table_id   = "table_from_tf"

  labels = {
    env = "default"
  }
  deletion_protection = false
}

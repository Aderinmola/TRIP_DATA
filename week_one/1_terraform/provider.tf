terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  project = "nimble-service-395221"
  region  = "us-central1"
  zone    = "us-central1-a"
  # credentials = file("nimble-service-395221-cd81064aae96.json")
}

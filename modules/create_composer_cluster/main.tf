provider "google" {
  project = "dataprod-cluster-testing-1"
  region  = "us-central1"
  zone    = "us-central1-f"
  credentials = file("dataprod-cluster-testing-1-7444c4c90649.json")
}

data "google_composer_image_versions" "all" {
}

resource "google_composer_environment" "pilot" {
  name   = "terraform-composer-cluster-test-1"
  region = "us-central1"
  project = "dataprod-cluster-testing-1"
  config {
    node_count=3
    software_config {
      image_version = data.google_composer_image_versions.all.image_versions[0].image_version_id
      // python_version = data.google_composer_image_versions.all.image_versions[0].supportedPythonVersions[1]
      python_version = "3"

    }
    node_config {
      zone = "us-central1-f"
      machine_type = "n1-standard-1"
      disk_size_gb = 20
      service_account = "742690957765-compute@developer.gserviceaccount.com"
    }
  }
  // depends_on = [google_project_iam_member.composer-worker]
  depends_on = [var.root_depends_on_dataproc_cluster]

}

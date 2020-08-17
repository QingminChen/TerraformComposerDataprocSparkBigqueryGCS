provider "google" {
  project = "dataprod-cluster-testing-1"
  region  = "us-central1"
  zone    = "us-central1-f"
  credentials = file("dataprod-cluster-testing-1-7444c4c90649.json")
}

data "google_composer_image_versions" "all" {
}

resource "google_storage_bucket" "dataproc-cluster-temp" {
  name = "dataproc_cluster_temp_by_terraform"
  location = "us-central1"
  project = "dataprod-cluster-testing-1"
  storage_class = "STANDARD"
  bucket_policy_only = true
  force_destroy = true
  depends_on = [var.root_depends_on_dataproc_prequisition]
}

resource "google_dataproc_cluster" "create_dataproc_cluster" {
  name     = "cluster-test-1"
  region   = "us-central1"
  project = "dataprod-cluster-testing-1"

  cluster_config {
    staging_bucket = "dataproc_cluster_temp_by_terraform"

    master_config {
      num_instances = 1
      machine_type  = "n1-standard-4"
      //machine_type  = "n1-standard-1"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 15
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = "n1-standard-2"
      //machine_type     = "n1-standard-1"
      // min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 15
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "1.4-debian9"
//      override_properties = {
//        "dataproc:dataproc.allow.zero.workers" = "true"
//      }
    }

    gce_cluster_config {
      zone = "us-central1-f"
//      tags = ["foo", "bar"]
      service_account = "742690957765-compute@developer.gserviceaccount.com"
      service_account_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }

    initialization_action {
      script      = "gs://integrate-source-code/configs/dataproc_init.sh"
      timeout_sec = 500
    }
  }
  depends_on = [google_storage_bucket.dataproc-cluster-temp]
}



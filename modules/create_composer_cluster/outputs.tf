output "terraform-composer-cluster-bucket" {
  value = "${google_composer_environment.pilot.config.0.dag_gcs_prefix}"
  //depends_on = [google_storage_bucket.]
}

output "terraform-composer-cluster-name" {
  value = "${google_composer_environment.pilot.config.0.gke_cluster}"
}

output "terraform-composer-cluster-airflow-uri" {
  value = "${google_composer_environment.pilot.config.0.airflow_uri}"
}

output "terraform-composer-cluster-resource-identifier" {
  value = "${google_composer_environment.pilot.id}"
}

//output "composer_cluster_depends_on" {
//    value = {}
//    depends_on = [google_composer_environment.pilot]
//}

output "composer_cluster_complete" {
    value = {}
    depends_on = [google_composer_environment.pilot]
}
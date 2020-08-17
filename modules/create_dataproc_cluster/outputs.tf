output "terraform-dataproc-cluster-master-names" {
  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.master_config.0.instance_names}"
}

output "terraform-dataproc-cluster-worker-names" {
  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.worker_config.0.instance_names}"
}

output "terraform-dataproc-cluster-preemptible-worker-names" {
  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.preemptible_worker_config.0.instance_names}"
}

output "terraform-dataproc-cluster-bucket-name" {
  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.bucket}"
}

output "terraform-dataproc-cluster-software-properties" {
  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.software_config.0.properties}"
}

//output "terraform-dataproc-cluster-idle-start-time" {
//  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.lifecycle_config.0.idle_start_time}"
//}


//output "terraform-dataproc-cluster-http_ports" {
//  value = "${google_dataproc_cluster.create_dataproc_cluster.cluster_config.0.endpoint_config.0.http_ports}"
//}

//output "dataproc_cluster_depends_on" {//used
//    value = {}
//    depends_on = [google_dataproc_cluster.create_dataproc_cluster]
//}


output "dataproc_cluster_complete" {//used
    value = {}
    depends_on = [google_dataproc_cluster.create_dataproc_cluster]
}
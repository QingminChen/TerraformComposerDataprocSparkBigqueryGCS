provider "google" {
  project = "dataprod-cluster-testing-1"
  region  = "us-central1"
  zone    = "us-central1-f"
  credentials = file("dataprod-cluster-testing-1-7444c4c90649.json")
}

data "google_composer_image_versions" "all" {
}

module "create_dataproc_cluster" {
  source = "./modules/create_dataproc_cluster"
  root_depends_on_dataproc_prequisition = [module.dataproc_prequisition.dataproc_prequisition_complete]   //used
}

module "create_composer_cluster" {
  source = "./modules/create_composer_cluster"
   root_depends_on_dataproc_cluster = [module.create_dataproc_cluster.dataproc_cluster_complete]
}

module "deploy_dag_jobs" {
  source = "./modules/deploy_dag_jobs"
  root-terraform-composer-cluster-bucket = "${module.create_composer_cluster.terraform-composer-cluster-bucket}"    //used
  root-terraform-composer-cluster-name = "${module.create_composer_cluster.terraform-composer-cluster-name}"        //used
  root-terraform-composer-cluster-airflow-uri = "${module.create_composer_cluster.terraform-composer-cluster-airflow-uri}"  //used
  root-terraform-composer-cluster-resource-identifier = "${module.create_composer_cluster.terraform-composer-cluster-resource-identifier}"  //used
  root_depends_on_composer_cluster = [module.create_composer_cluster.composer_cluster_complete]
}

//module "gcloud" {
//  source                            = "terraform-google-modules/gcloud/google"
//  version                           = "~> 1.3"
//  use_tf_google_credentials_env_var = "true"
//
//  create_cmd_body  = "iam service-accounts disable ${module.project_factory.service_account_name}"
//  destroy_cmd_body = "iam service-accounts enable ${module.project_factory.service_account_name}"
//}



module "dataproc_prequisition" {
  source = "./modules/dataproc_prequisition"



//  root-terraform-composer-cluster-bucket = "${module.create_composer_cluster.terraform-composer-cluster-bucket}"    //used
//  root-terraform-composer-cluster-name = "${module.create_composer_cluster.terraform-composer-cluster-name}"        //used
//  root-terraform-composer-cluster-airflow-uri = "${module.create_composer_cluster.terraform-composer-cluster-airflow-uri}"  //used
//  root-terraform-composer-cluster-resource-identifier = "${module.create_composer_cluster.terraform-composer-cluster-resource-identifier}"  //used

//  root-terraform-dataproc-cluster-master-names = "${module.create_dataproc_cluster.terraform-dataproc-cluster-master-names}"  //used
//  root-terraform-dataproc-cluster-worker-names = "${module.create_dataproc_cluster.terraform-dataproc-cluster-worker-names}"  //used
//  root-terraform-dataproc-cluster-preemptible-worker-names = "${module.create_dataproc_cluster.terraform-dataproc-cluster-preemptible-worker-names}"  //used
//  root-terraform-dataproc-cluster-bucket-name = "${module.create_dataproc_cluster.terraform-dataproc-cluster-bucket-name}"  //used
//  root-terraform-dataproc-cluster-software-properties = "${module.create_dataproc_cluster.terraform-dataproc-cluster-software-properties}"  //used
//  // root-terraform-dataproc-cluster-http_ports = "${module.create_dataproc_cluster.terraform-dataproc-cluster-http_ports}"   no use

  root-scala-code-jar-bucket = "${module.dataproc_prequisition.scala-code-jar-bucket}" //used

//  root_composer_cluster_depends_on = [module.create_composer_cluster.composer_cluster_depends_on]   //used

}


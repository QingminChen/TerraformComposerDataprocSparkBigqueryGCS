provider "google" {
  project = "dataprod-cluster-testing-1"
  region  = "us-central1"
  zone    = "us-central1-f"
  credentials = file("dataprod-cluster-testing-1-7444c4c90649.json")
}

data "google_composer_image_versions" "all" {
}


resource "google_storage_bucket_object" "upload-airflow-script" {    //used
  name   = "dags/airflowtest4.py"
  source = "/Users/chenqingmin/Codes/terraform_test_project_temp/airflowtest4.py"
  bucket = trimsuffix(trimprefix(var.root-terraform-composer-cluster-bucket,"gs://"),"/dags")
  //bucket = trimsuffix(trimprefix("gs://us-central1-terraform-compo-f7bb6d6c-bucket/dags","gs://"),"/dags")
  content_type = "text/x-python"
  depends_on = [var.root_depends_on_composer_cluster]
}






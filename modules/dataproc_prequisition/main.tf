provider "google" {
  project = "dataprod-cluster-testing-1"
  region  = "us-central1"
  zone    = "us-central1-f"
  credentials = file("dataprod-cluster-testing-1-7444c4c90649.json")
}

data "google_composer_image_versions" "all" {
}

//resource "null_resource" "upload_folder_content" {
// // triggers = {
// //         file_hashes = jsonencode(
// //             {
// //                  for fn in fileset(var.folder_path, "**") :
// //                       fn => filesha256("${var.folder_path}/${fn}")
// //             }
// //         )
// // }
//
//
// provisioner "local-exec" {
//   command = "gsutil cp -r /Users/chenqingmin/Codes/terraform_test_project_temp/airflowtest4.py gs://us-central1-terraform-compo-f7bb6d6c-bucket/dags"
// }
//}


//resource "google_storage_bucket_acl" "owner-acl" {
//  bucket = "gs://us-central1-terraform-compo-f7bb6d6c-bucket"
//
//  role_entity = [
//    "WRITER:user-742690957765-compute@developer.gserviceaccount.com",
//  ]
//}

//resource "google_storage_bucket_object" "upload-airflow-script" {    //It didn't work on my laptop mac  gsutil command not found
//   name   = "airflowtest4.py"
//   source = "/Users/chenqingmin/Codes/terraform_test_project_temp/airflowtest4.py"
//   //bucket = trimsuffix(trimpreffix(var.root-terraform-composer-cluster-bucket,"gs://"),"/dags")
//  bucket = "us-central1-terraform-compo-f7bb6d6c-bucket"
//
//
//   provisioner "local-exec" {
//         command = "gsutil cp -r $source gs://$bucket/dags"
//   }
//}


//resource "google_storage_bucket" "dataproc-cluster-temp" {    //no use
//  name = "dataproc_cluster_temp_by_composer"
//  location = "us-central1"
//  project = "dataprod-cluster-testing-1"
//  storage_class = "STANDARD"
//  bucket_policy_only = true
//}

//self_link - The URI of the created resource.
//url - The base URL of the bucket, in the format gs://<bucket-name>.

//locals { I think this keywords just perform the equivalent function like constant
//  # Ids for multiple sets of EC2 instances, merged together
//  scala_code_jar_bucket = "${google_storage_bucket.source-code.url}"
//}









//resource "google_storage_bucket_object" "upload-airflow-script" {    //used
//  name   = "dags/airflowtest4.py"
//  source = "/Users/chenqingmin/Codes/terraform_test_project_temp/airflowtest4.py"
//  bucket = trimsuffix(trimprefix(var.root-terraform-composer-cluster-bucket,"gs://"),"/dags")
//  //bucket = trimsuffix(trimprefix("gs://us-central1-terraform-compo-f7bb6d6c-bucket/dags","gs://"),"/dags")
//  content_type = "text/x-python"
//  depends_on = [google_storage_bucket_object.upload-scala-jar]
//}

//terraform {            //no use
//  backend "gcs" {
//    bucket  = "integrate-source-code"
//    //prefix  = "terraform/state"
//    credentials = "/Users/chenqingmin/Codes/terraform_test_project_temp/dataprod-cluster-testing-1-7444c4c90649.json"
//  }
//}

resource "google_storage_bucket" "create-source-code-bucket" {  //use
  name = "integrate-source-code"
  location = "us-central1"
  project = "dataprod-cluster-testing-1"
  storage_class = "STANDARD"
  bucket_policy_only = true
  force_destroy = true
  //depends_on = [var.root_composer_cluster_depends_on]
}

//resource "google_storage_bucket_iam_member" "grant_user_admin_bucket" {    //no use
//  bucket = trimprefix("${var.root-scala-code-jar-bucket}","gs://")
//  role = "roles/storage.admin"
//  member = "serviceAccount:742690957765-compute@developer.gserviceaccount.com"
//  depends_on = [google_storage_bucket.create-source-code-bucket]
//}
//
//resource "google_storage_bucket_iam_member" "grant_user_objectAdmin_bucket" {  //no use
//  bucket = trimprefix("${var.root-scala-code-jar-bucket}","gs://")
//  role = "roles/storage.objectAdmin"
//  member = "serviceAccount:742690957765-compute@developer.gserviceaccount.com"
//  depends_on = [google_storage_bucket.create-source-code-bucket]
//}

resource "google_storage_bucket_object" "upload-scala-jar" {     //used
  name   = "codes/"
  //source = "/Users/chenqingmin/Codes/terraform_test_project_temp/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar"
  //bucket = "${var.root-scala-code-jar-bucket}"
  content = "Not really a directory, but it's empty"
  bucket = trimprefix("${var.root-scala-code-jar-bucket}","gs://")
  //bucket = trimsuffix(trimprefix("gs://us-central1-terraform-compo-f7bb6d6c-bucket/dags","gs://"),"/dags")
  content_type = "application/java-archive"
  provisioner "local-exec" {
    command = "gsutil cp -r /Users/chenqingmin/Codes/terraform_test_project_temp/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar ${var.root-scala-code-jar-bucket}/codes"
  }
  //depends_on = [google_storage_bucket_iam_member.grant_user_admin_bucket,google_storage_bucket_iam_member.grant_user_objectAdmin_bucket]
  depends_on = [google_storage_bucket_object.upload-dataproc-init-script]
}


resource "google_storage_bucket_object" "upload-json-file" {     //used
  name   = "security/"
  content = "Not really a directory, but it's empty"
  bucket = trimprefix("${var.root-scala-code-jar-bucket}","gs://")
  content_type = "application/json"
  provisioner "local-exec" {
    command = "gsutil cp -r /Users/chenqingmin/Codes/terraform_test_project_temp/AllServicesKey.json ${var.root-scala-code-jar-bucket}/security"
  }
  depends_on = [null_resource.auth_gcloud]
}

resource "google_storage_bucket_object" "upload-dataproc-init-script" {     //used
  name   = "configs/"
  content = "Not really a directory, but it's empty"
  bucket = trimprefix("${var.root-scala-code-jar-bucket}","gs://")
  content_type = "text/x-sh"
  provisioner "local-exec" {
    command = "gsutil cp -r /Users/chenqingmin/Codes/terraform_test_project_temp/dataproc_init.sh ${var.root-scala-code-jar-bucket}/configs"
  }
  depends_on = [google_storage_bucket_object.upload-json-file]
}


//resource "null_resource" "transfer_auth_file_dataproc_instance_master" {   // no used
//  provisioner "local-exec" {
//    command = "gcloud compute scp --project=dataprod-cluster-testing-1 --zone=us-central1-f /Users/chenqingmin/Codes/terraform_test_project_temp/AllServicesKey.json ${var.root-terraform-dataproc-cluster-worker-names[0]}:/home/testinggcpuser"
//
//  }
//
////  provisioner "local-exec" {
////    command = "gcloud compute networks create private_transfer_network --project dataprod-cluster-testing-1"
////
////  }
//
////  provisioner "local-exec" {
////    command = "gcloud compute firewall-rules create firewall_rules_myself_allssh --project dataprod-cluster-testing-1 --network private_transfer_network --allow tcp:22"
////
////  }
//  //depends_on = [google_storage_bucket.create-source-code-bucket]   // used
//}


//resource "null_resource" "transfer_auth_file_dataproc_instance_work_0" {  //no used
//
//  provisioner "local-exec" {
//    command = "gcloud compute scp --project=dataprod-cluster-testing-1 --zone=us-central1-f /Users/chenqingmin/Codes/terraform_test_project_temp/AllServicesKey.json ${var.root-terraform-dataproc-cluster-worker-names[1]}:/home/testinggcpuser"
//
//  }
//  depends_on = [null_resource.transfer_auth_file_dataproc_instance_master]
//}

//resource "null_resource" "transfer_auth_file_dataproc_instance_work_1" {   // no used
//
//  provisioner "local-exec" {
//    command = "gcloud compute scp --project=dataprod-cluster-testing-1 --zone=us-central1-f /Users/chenqingmin/Codes/terraform_test_project_temp/AllServicesKey.json ${var.root-terraform-dataproc-cluster-master-names[2]}:/home/testinggcpuser"
//
//  }
//  depends_on = [null_resource.transfer_auth_file_dataproc_instance_work_0]
//}

resource "null_resource" "auth_gcloud" {   //no used
  provisioner "local-exec" {
    command = "gcloud auth activate-service-account 742690957765-compute@developer.gserviceaccount.com --key-file=/Users/chenqingmin/Codes/terraform_test_project_temp/dataprod-cluster-testing-1-7444c4c90649.json --project=dataprod-cluster-testing-1" //it worked
    //command = "gcloud config set core/account testinggcpuser@gmail.com"
  }
  depends_on = [google_storage_bucket.create-source-code-bucket]   // used
}


//resource "null_resource" "revoke_auth_gcloud" {  //no used
//  provisioner "local-exec" {
//    command = "gcloud auth revoke 742690957765-compute@developer.gserviceaccount.com" //it worked   even you gcloud config set account account testinggcpuser@gmail.com, it doesn't mean you have the credentials
//  }
//  //depends_on = [google_storage_bucket_object.upload-scala-jar]
//  depends_on = [null_resource.transfer_auth_file_dataproc_instance_work_1]
//}

//resource "null_resource" "upload_folder_content" {   //no used
// provisioner "local-exec" {
//   command = "gsutil cp -r /Users/chenqingmin/Codes/terraform_test_project_temp/sparkSQL-BQ-GS-1.0-SNAPSHOT-jar-with-dependencies.jar ${var.root-scala-code-jar-bucket}"
// }
//  depends_on = [google_storage_bucket.create-source-code-bucket]
//}






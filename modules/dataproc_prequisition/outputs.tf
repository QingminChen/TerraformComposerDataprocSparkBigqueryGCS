output "scala-code-jar-bucket" {   //use
  value = "${google_storage_bucket.create-source-code-bucket.url}"
}

output "dataproc_prequisition_complete" {
    value = {}
    depends_on = [google_storage_bucket_object.upload-scala-jar]
}
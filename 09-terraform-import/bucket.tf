# Recurso que vamos criar na cloud AWS
resource "aws_s3_bucket" "bucket_terraform_import" {
  # Nome visual do recurso S3
  bucket = "terraform-274674695952"
}

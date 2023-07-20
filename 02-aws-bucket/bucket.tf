# Recurso que vamos criar na cloud AWS
resource "aws_s3_bucket" "first_bucket" {
  # Nome visual do recurso S3
  bucket = "curso-terraform-gustavolopes"
}

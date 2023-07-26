# Recurso que vamos criar na cloud AWS
resource "aws_s3_bucket" "first_bucket" {
  # Nome visual do recurso S3
  bucket = "gustavolopes-remote-state"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.first_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket" "luisyedward" {
  bucket = var.name_bucket

  tags = {
    Name        = "Mi bucket"
    Environment = "Dev"
  }
}
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.luisyedward.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

output arn {
  value       = aws_kms_key.mykey.arn
  sensitive   = false
  description = "description"
  depends_on  = []
}

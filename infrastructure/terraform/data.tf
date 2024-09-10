
data "aws_s3_bucket" "bucket" {
  bucket = var.lambda_layer_bucket
}

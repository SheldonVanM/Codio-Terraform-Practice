# ############################################################################################################
# ### S3 Bucket Management ###
# ############################################################################################################
# # Create the S3 bucket
# resource "aws_s3_bucket" "oracle-python-layer-bucket" {
#   bucket = var.lambda_layer_bucket
# }

# # Upload zip file for the 
# resource "aws_s3_object" "python_oracle_connection_layer_zip" {
#   bucket = aws_s3_bucket.oracle-python-layer-bucket.id
#   key    = "lambda_layers/${local.layer_name}/${local.layer_zip_path}"
#   source = local.oracle_connection_layer_path
#   etag   = filebase64sha256("./../zip/layers/oracle-layer.zip")
# }


# # AWS LAMBDA LAYERS #
# resource "aws_lambda_layer_version" "python_oracle_connection_layer" {
#   s3_bucket           = aws_s3_bucket.oracle-python-layer-bucket.id
#   s3_key              = aws_s3_object.python_oracle_connection_layer_zip.key
#   layer_name          = local.layer_name
#   compatible_runtimes = [var.python_oracle_connection_layer_compatible_runtimes]
#   #skip_destroy = true
# }

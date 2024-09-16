############################################################################################################
### RESOURCES ###
############################################################################################################

locals {
  layer_zip_path               = "layer.zip"
  layer_name                   = "python-oracle-connection-layer"
  oracle_connection_layer_path = "./../zip/layers/oracle-layer.zip"
}

############################################################################################################
### LAMBDA & AUXILLARIES ###
############################################################################################################
resource "aws_lambda_function" "core-substance-registration-api-lambda" {
  description   = "Lambda function to handle application requests fed in from API"
  function_name = var.lambda_function_name
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
  filename      = var.path_to_application_zip
  memory_size   = 512
  timeout       = 300
  layers = [
    #aws_lambda_layer_version.python-oracle-connection-layer,
    var.aws_lambda_cloud_insights_arn,
    var.aws_secret_parameter_extension_layer_arn
  ]
}


############################################################################################################
### S3 ###
############################################################################################################
# Create the S3 bucket
resource "aws_s3_bucket" "oracle-python-layer-bucket" {
  bucket = var.lambda_layer_bucket
}

# Upload zip file for the 
resource "aws_s3_object" "python_oracle_connection_layer_zip" {
  bucket = aws_s3_bucket.oracle-python-layer-bucket.id
  key    = "lambda_layers/${local.layer_name}/${local.layer_zip_path}"
  source = local.oracle_connection_layer_path
  etag   = filebase64sha256("./../zip/layers/oracle-layer.zip")
}


# AWS LAMBDA LAYERS #
resource "aws_lambda_layer_version" "python_oracle_connection_layer" {
  s3_bucket           = aws_s3_bucket.oracle-python-layer-bucket.id
  s3_key              = aws_s3_object.python_oracle_connection_layer_zip.key
  layer_name          = local.layer_name
  compatible_runtimes = [var.python_oracle_connection_layer_compatible_runtimes]
  #skip_destroy = true
}

############################################################################################################
### IAM ###
############################################################################################################

# IAM Role #
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
    }]
  })
}

# IAM Policy #
resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:ListTagsLogGroup"
      ],
      Effect   = "Allow",
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}

# IAM Policy Attachment *
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

############################################################################################################
### CloudWatch Insights ###
############################################################################################################
resource "aws_cloudwatch_log_group" "lambda_function_log_group" {
  name              = var.aws_cloudwatch_log_group_name
  retention_in_days = var.aws_cloudwatch_retention_days
}






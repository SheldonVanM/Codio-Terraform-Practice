
variable "region" {
  description = "The AWS region we will use"
  default     = "us-east-1"
  type        = string
}

variable "path_to_application_zip" {
  description = "Path to application zip file"
  default     = "./../zip/app/src.zip"
  type        = string
}

variable "path_to_layer_zip" {
  description = "Path to application zip file"
  default     = "./../zip/layers/oracle-layer.zip"
  type        = string
}

variable "aws_secret_parameter_extension_layer_arn" {
  description = "ARN for Secret Parameter layer"
  default     = "arn:aws:lambda:us-east-1:177933569100:layer:AWS-Parameters-and-Secrets-Lambda-Extension:11"
  type        = string
}

variable "lambda_layer_bucket" {
  description = "The s3 bucket to contain the zip for the Oracle connection layer"
  default     = "python-oracle-connection-layer-bucket"
}

variable "lambda_function_name" {
  description = "The lambda layer function"
  default     = "core-substance-registration-api"
}

variable "python_oracle_connection_layer_compatible_runtimes" {
  description = "The compatible runtimes for the Python Oracle connection layer"
  default     = "python3.8"
  type        = string
}

variable "aws_lambda_cloud_insights_arn" {
  description = "ARN for Lambda Cloud Watch Insights"
  default     = "arn:aws:lambda:us-east-1:580247275435:layer:LambdaInsightsExtension:53"
  type        = string
}

variable "aws_cloudwatch_log_group_name" {
  description = "Log group name for CloudWatch"
  default     = "practice-cloudwatch-logs"
  type        = string
}

variable "aws_cloudwatch_retention_days" {
  description = "Retention days for CloudWatch"
  default     = 14
  type        = number
}

variable "dashboard-name" {
  description = "The name for the Cloudwatch dashboard which will be created"
  default     = "CSR-API-lambda"
  type        = string
}


variable "default_vpc_id" {
  description = "The Amgen VPC to connect resources to"
  default     = "TODO"
  type        = string
}

variable "subnet_ids" {
  description = "Amgen Atmos subnets"
  type        = set(string)
  default     = ["TODO"]
}

variable "default_security_group" {
  description = "The security group to connect to connect to Amgens Atmos VPC"
  type        = string
  default     = "TODO"
}

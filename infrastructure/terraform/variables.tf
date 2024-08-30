
variable "region" {
  description = "The AWS region we will use"
  default     = "us-east-1"
  type        = string
}

variable "path_to_application_zip" {
  description = "Path to application zip file"
  default     = "./../zip/app/src.zip"
}

variable "path_to_layer_zip" {
  description = "Path to application zip file"
  default     = "./../zip/layer/pythonOracleConnectionLayer.zip"
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

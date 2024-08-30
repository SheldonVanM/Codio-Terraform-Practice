############################################################################################################
### RESOURCES ###
############################################################################################################

############################################################################################################
### LAMBDA & AUXILLARIES ###
############################################################################################################
resource "aws_lambda_function" "core-substance-registration-api-lambda" {
  function_name = "core-substance-registration-api"
  handler       = "app.lambda_function"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_role.arn
  filename      = var.path_to_application_zip
  memory_size   = 512
  timeout       = 300
  layers        = [aws_lambda_layer_version.python-oracle-connection-layer]
  description   = "Lambda function to handle application requests fed in from API"
}

# AWS LAMBDA LAYERS #
resource "aws_lambda_layer_version" "python-oracle-connection-layer" {
  filename            = var.path_to_layer_zip
  layer_name          = "pythonOracleConnectionLayer"
  compatible_runtimes = ["python3.8"]
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
        "logs:PutLogEvents"
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



# API GATEWAY #


# CLOUDWATCH #
# resource "aws_cloudwatch_dashboard" "demo-lambda-dashboard" {
#   dashboard_name = "demo-dashboard-${var.dashboard-name}"
#   dashboard_body = jsonencode({
#     widgets = [
#       {
#         type   = "metric"
#         x      = 0
#         y      = 0
#         width  = 6
#         height = 12
#         properties = {
#           metrics = [
#             [
#               "AWS/Lambda",
#               "Invocations"
#             ]
#           ]
#         }
#         period = 300
#       }
#     ]
#   })
# }



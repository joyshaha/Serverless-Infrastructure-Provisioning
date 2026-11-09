# Custom Lambda execution role
resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# CloudWatch Logs permissions
resource "aws_iam_role_policy" "lambda_logging" {
  name = "${var.function_name}-logging-policy"

  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = [
          "arn:aws:logs:*:*:*"
        ]
      }
    ]
  })
}

# Lambda function
resource "aws_lambda_function" "this" {
  function_name = var.function_name

  filename = var.filename
  source_code_hash = filebase64sha256(var.filename)
  
  runtime = var.runtime
  handler = var.handler
  role = aws_iam_role.lambda_execution_role.arn
  timeout = var.timeout
  memory_size = var.memory_size

  environment {
    variables = var.environment_variables
  }

  depends_on = [
    aws_iam_role_policy.lambda_logging
  ]
}
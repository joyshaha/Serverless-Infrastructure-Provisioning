output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.this.arn
}

output "lambda_invoke_arn" {
  description = "Lambda invocation ARN for API Gateway"
  value       = aws_lambda_function.this.invoke_arn
}

output "lambda_execution_role_arn" {
  description = "Lambda execution role ARN"
  value       = aws_iam_role.lambda_execution_role.arn
}
output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "lambda_execution_role_arn" {
  value = module.lambda.lambda_execution_role_arn
}

output "api_gateway_url" {
  value = module.api_gateway.api_gateway_url
}

output "api_gateway_id" {
  value = module.api_gateway.rest_api_id
}
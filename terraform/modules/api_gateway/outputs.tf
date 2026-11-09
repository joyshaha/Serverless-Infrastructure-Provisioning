output "rest_api_id" {
  description = "REST API ID"
  value       = aws_api_gateway_rest_api.this.id
}

output "rest_api_execution_arn" {
  description = "REST API execution ARN"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "api_gateway_url" {
  description = "API Gateway stage URL"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "api_gateway_stage_name" {
  description = "API Gateway stage name"
  value       = aws_api_gateway_stage.this.stage_name
}
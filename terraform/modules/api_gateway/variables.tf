variable "api_name" {
  description = "API Gateway REST API name"
  type        = string
  default     = "my_api"
}

variable "stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "dev"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_function_arn" {
  description = "Lambda function ARN"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Lambda invocation ARN"
  type        = string
}
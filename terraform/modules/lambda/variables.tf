variable "function_name" {
  description = "Lambda function name"
  type        = string
  default     = "my_lambda_function"
}

variable "runtime" {
  description = "Python Lambda runtime"
  type        = string
  default     = "python3.14"
}

variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = "app.lambda_handler"
}

variable "filename" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "environment_variables" {
  description = "Lambda environment variables"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda memory in MB"
  type        = number
  default     = 256
}
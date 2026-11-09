# # Call the VPC module
# module "vpc" {
#   source                  = "../modules/vpc"
#   ipv4_primary_cidr_block = var.vpc_ipv4_primary_cidr_block
#   instance_tenancy        = var.vpc_instance_tenancy
# }

# # Call the Private Subnet module
# module "private_subnet" {
#   source                    = "../modules/subnet"
#   vpc_id                    = module.vpc.vpc_id
#   private_subnet_cidr_block = var.vpc_private_subnet_cidr_block
# }

# # Call EC2 module
# module "ec2" {
#   source = "../modules/ec2"
#   # vpc_id = module.vpc.vpc_id
#   # subnet_id = module.private_subnet.subnet_id
#   # instance_type = "t2.micro"
#   # ami_id = "ami-0c55b159cbfafe1f0"
# }


# Call Lambda module
module "lambda" {
  source        = "../modules/lambda"
  function_name = "dev-python-api"
  runtime       = "python3.14"
  handler       = "app.lambda_handler"
  # filename = "${path.module}/lambda.zip"
  filename    = "../../lambda.zip"
  timeout     = 30
  memory_size = 256

  environment_variables = {
    ENVIRONMENT = "dev"
    LOG_LEVEL   = "INFO"
  }
}

# # Call API Gateway module
# module "api_gateway" {
#   source = "../modules/api_gateway"

#   api_name             = "dev-python-rest-api"
#   stage_name           = "dev"
#   lambda_invoke_arn    = module.lambda.lambda_invoke_arn
#   lambda_function_name = module.lambda.lambda_function_name
#   lambda_function_arn  = module.lambda.lambda_function_arn
# }

# Call API Gateway module
module "api_gateway" {
  source = "../modules/nested_api_gateway"

  api_name             = "dev-python-nested-rest-api"
  stage_name           = "dev"
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
  lambda_function_arn  = module.lambda.lambda_function_arn
}
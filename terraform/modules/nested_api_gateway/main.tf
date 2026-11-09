/*
You want two shared Lambda proxy integrations:
1. Root-level proxy: /{proxy+}
2. Nested proxy: /event/{proxy+}
*/

# Step 1: Create REST API
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = "REST API integrated with Lambda"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Step 2: Create proxy resource: This creates the API resource with a path parameter `{proxy+}` that allows for any subpath to be matched.
resource "aws_api_gateway_resource" "root_proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id = aws_api_gateway_rest_api.this.root_resource_id
  path_part = "{proxy+}"
}

# Creates the path resource endpoint (e.g., /event)
resource "aws_api_gateway_resource" "event" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "event"
}

resource "aws_api_gateway_resource" "event_proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.event.id
  path_part   = "{proxy+}"
}

# Step 3: Create ANY method: This allows the API to accept any HTTP method (GET, POST, PUT, DELETE, etc.) for the proxy resource. For production, replace NONE with an appropriate authorization mechanism.

# Connect both proxy resources to the same Lambda
locals {
  proxy_resources = {
    root = aws_api_gateway_resource.root_proxy.id
    event = aws_api_gateway_resource.event_proxy.id
  }
}

resource "aws_api_gateway_method" "proxy" {
  for_each = local.proxy_resources

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = each.value
  http_method = "ANY"
  authorization = "NONE"
}

# Step 4: Lambda proxy integration: This sets up the integration between the API Gateway and the Lambda function. The `uri` is constructed using the Lambda function's ARN.
resource "aws_api_gateway_integration" "lambda" {
  for_each = local.proxy_resources

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = each.value
  http_method = aws_api_gateway_method.proxy[each.key].http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = var.lambda_invoke_arn
}

# Step 5: Lambda invocation permission: This allows the API Gateway to invoke the Lambda function. The `source_arn` is constructed using the API Gateway's ARN and the stage name.
resource "aws_lambda_permission" "api_gateway" {
  statement_id = "AllowApiGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}

# Step 6: API Gateway deployment: This creates a deployment of the API Gateway. The `depends_on` ensures that the deployment occurs after the integration and permission resources are created.
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.root_proxy.id,
      aws_api_gateway_resource.event.id,
      aws_api_gateway_resource.event_proxy.id,

      aws_api_gateway_method.proxy,
      aws_api_gateway_integration.lambda
    ]))
  }

  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_method.proxy
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Step 7: Create stage: This creates a stage for the API Gateway deployment. The `stage_name` is provided as a variable, allowing for flexibility in naming the stage (e.g., "dev", "prod").
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
}
import json


def lambda_handler(event, context):
    """
    Lambda proxy integration handler.
    """

    print("Received event:", json.dumps(event))

    # HTTP request method
    http_method = event.get("httpMethod", "UNKNOWN")

    # Requested API path
    path = event.get("path", "/")

    # Request headers
    headers = event.get("headers") or {}

    # Request body
    body = event.get("body")

    # Parse JSON request body
    if body:
        try:
            payload = json.loads(body)
        except json.JSONDecodeError:
            return {
                "statusCode": 400,
                "headers": {
                    "Content-Type": "application/json",
                },
                "body": json.dumps({
                    "message": "Invalid JSON payload"
                })
            }
    else:
        payload = {}

    # Business logic
    response_data = {
        "message": "Lambda executed successfully",
        "method": http_method,
        "path": path,
        "payload": payload,
        "request_id": context.aws_request_id,
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "X-Application": "Python-Lambda",
        },
        "body": json.dumps(response_data),
    }

# Zip the Lambda function code to create a deployment package and upload it to AWS Lambda
# zip lambda.zip app.py

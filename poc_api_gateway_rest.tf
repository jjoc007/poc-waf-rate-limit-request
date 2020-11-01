resource "aws_api_gateway_rest_api" "poc_rest_api" {
  name        = "poc_waf_api"
  description = "API Gateway for Stack"
}

resource "aws_api_gateway_stage" "poc_api_stage" {
  stage_name    = "stage_dev"
  rest_api_id   = aws_api_gateway_rest_api.poc_rest_api.id
  deployment_id = aws_api_gateway_deployment.poc_api_rest_dev_development.id
}

resource "aws_api_gateway_deployment" "poc_api_rest_dev_development" {
  depends_on = [
    aws_api_gateway_integration.poc_my_service_get_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.poc_rest_api.id
  stage_name  = "dev"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_resource" "poc_my_service_resource" {
  rest_api_id = aws_api_gateway_rest_api.poc_rest_api.id
  parent_id   = aws_api_gateway_rest_api.poc_rest_api.root_resource_id
  path_part   = "my-service"
}

resource "aws_api_gateway_method" "poc_my_service_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.poc_rest_api.id
  resource_id   = aws_api_gateway_resource.poc_my_service_resource.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "poc_my_service_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.poc_rest_api.id
  resource_id             = aws_api_gateway_resource.poc_my_service_resource.id
  http_method             = aws_api_gateway_method.poc_my_service_get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.poc_my_service.invoke_arn
}

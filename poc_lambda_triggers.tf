resource "aws_lambda_permission" "lambda_permission_my_service_rest" {
  depends_on    = [aws_lambda_function.poc_my_service]
  principal     = "apigateway.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.poc_my_service.function_name
  source_arn = "${aws_api_gateway_rest_api.poc_rest_api.execution_arn}/*/${aws_api_gateway_method.poc_my_service_get_method.http_method}${aws_api_gateway_resource.poc_my_service_resource.path}"
}

resource "aws_lambda_function" "poc_my_service" {
  filename      =  data.archive_file.my_service_zip.output_path
  function_name = "poc_my_service_lambda"
  role          = aws_iam_role.poc_lambda_role.arn
  handler       = "handler.lambda_handler"
  source_code_hash = data.archive_file.my_service_zip.output_base64sha256
  runtime = "python3.8"
}
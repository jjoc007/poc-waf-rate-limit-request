data "archive_file" "my_service_zip" {
  type        = "zip"
  source_dir = "resources/lambdas/my-service"
  output_path = "resources/lambdas/my-service.zip"
}

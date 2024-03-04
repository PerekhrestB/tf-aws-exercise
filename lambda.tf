
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/static/function.py"
  output_path = "${path.module}/static/function.py.zip"
}

resource "aws_lambda_function" "hello_world_function" {
  function_name = "hello_world_function_tf"
  filename      = data.archive_file.lambda_zip.output_path
  runtime       = "python3.8"
  handler       = "function.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role = aws_iam_role.lambda_function_role.arn

}

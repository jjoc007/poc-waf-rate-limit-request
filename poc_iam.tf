resource "aws_iam_role" "poc_lambda_role" {
  name               = "poc_waf_lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "poc_lambda_default_policy_all" {
  name   = "stereotheque_lambda_default_policy_all"
  policy = data.aws_iam_policy_document.poc_default_lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_ws_to_default" {
  role       = aws_iam_role.poc_lambda_role.name
  policy_arn = aws_iam_policy.poc_lambda_default_policy_all.arn
}

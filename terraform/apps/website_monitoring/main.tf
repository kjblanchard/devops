resource "aws_sns_topic" "wedding_topic" {
  name = "wedding-monitoring-topic"
}

resource "aws_sns_topic_subscription" "wedding_subscription" {
  protocol  = "email"
  endpoint  = var.email
  topic_arn = aws_sns_topic.wedding_topic.arn
}


# Lambda
data "aws_iam_policy_document" "basic_lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "sns_publish" {
  statement {

    actions = [
      "sns:Publish",
    ]

    resources = [
      aws_sns_topic.wedding_topic.arn
    ]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_wedding_lambda"
  assume_role_policy = data.aws_iam_policy_document.basic_lambda_assume_role.json
  inline_policy {
    name   = "SNS_Publish"
    policy = data.aws_iam_policy_document.sns_publish.json
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "main.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename         = "lambda_function_payload.zip"
  function_name    = "wedding_website_uptime_notifications"
  role             = aws_iam_role.iam_for_lambda.arn
  runtime          = "python3.10"
  handler          = "main.lambda_handler"
  timeout          = 10
  source_code_hash = data.archive_file.lambda.output_base64sha256
  environment {
    variables = {
      TOPIC = aws_sns_topic.wedding_topic.arn
      URI = var.website
    }
  }

}

# Cron
resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "wedding_uptime_check_daily"
  description         = "Schedule for wedding uptime checker"
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "schedule_lambda" {
  rule      = aws_cloudwatch_event_rule.schedule.name
  target_id = "processing_lambda"
  arn       = aws_lambda_function.test_lambda.arn
}


resource "aws_lambda_permission" "allow_events_bridge_to_run_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "events.amazonaws.com"
}

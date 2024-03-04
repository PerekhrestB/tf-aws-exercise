resource "aws_amplify_app" "GettingStartedTf" {
  name       = "GettingStartedTf"
  repository = "https://github.com/PerekhrestB/amplify-html"

  access_token = var.GITHUB_ACCESS_TOKEN

  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.GettingStartedTf.id
  branch_name = "main"
}

resource "aws_amplify_webhook" "main" {
  app_id      = aws_amplify_app.GettingStartedTf.id
  branch_name = aws_amplify_branch.main.branch_name
  description = "triggermaster"
}
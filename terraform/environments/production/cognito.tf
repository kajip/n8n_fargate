// Cognito 定義

resource "aws_cognito_user_pool" "n8n" {
  name = var.service_name
}

resource "aws_cognito_user_pool_client" "client" {
  name         = var.service_name
  user_pool_id = aws_cognito_user_pool.n8n.id
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.service_name
  user_pool_id = aws_cognito_user_pool.n8n.id
}

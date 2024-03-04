
resource "aws_api_gateway_rest_api" "hello_world_api_tf" {

  name = "hello_world_api_tf"

  endpoint_configuration {
    types = ["EDGE"]
  }
}


resource "aws_api_gateway_resource" "root" {

  rest_api_id = aws_api_gateway_rest_api.hello_world_api_tf.id
  parent_id   = aws_api_gateway_rest_api.hello_world_api_tf.root_resource_id
  path_part   = "index"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.hello_world_api_tf.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "POST"
  authorization = "NONE"

}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.hello_world_api_tf.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"


  //cors section

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true

  }

}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.hello_world_api_tf.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code
  //cors

  response_parameters = {

    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",

    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",

    "method.response.header.Access-Control-Allow-Origin" = "'*'"

  }

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.function_integration
  ]

}


resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.function_integration

  ]
  rest_api_id = aws_api_gateway_rest_api.hello_world_api_tf.id
  stage_name = "dev"

}
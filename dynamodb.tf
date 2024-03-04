resource "aws_dynamodb_table" "hello_world_database" {
  name         = "hello-world-database-tf"
  hash_key     = "ID"
  billing_mode = "PAY_PER_REQUEST"


  attribute {
    name = "ID"
    type = "S"
  }

}

variable "tf_state_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
  default     = "foodie-terraform-state-winters"
}

variable "tf_state_key" {
  description = "S3 key for Terraform state"
  type        = string
  default     = "ecs/terraform.tfstate"
}

variable "tf_lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = "foodie-lock-table"
}

terraform {
  backend "s3" {
    bucket         = "foodie-terraform-state-winters"
    key            = "ecs/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "foodie-lock-table"
  }
}
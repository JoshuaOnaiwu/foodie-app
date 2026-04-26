data "aws_ecr_repository" "repo" {
  name = var.ecr_repository_name
}

locals {
  ecr_repository_url = data.aws_ecr_repository.repo.repository_url
}
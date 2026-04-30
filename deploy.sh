#!/bin/bash

set -e

echo "🚀 Starting deployment..."

# Generate image tag from git
IMAGE_TAG=$(git rev-parse HEAD)

echo "📦 Using image tag: $IMAGE_TAG"

# Move into infra folder
cd infra

echo "🔧 Initializing Terraform..."
terraform init

echo "⚡ Applying Terraform..."
terraform apply -auto-approve -var="image_tag=$IMAGE_TAG"

echo "✅ Deployment complete!"
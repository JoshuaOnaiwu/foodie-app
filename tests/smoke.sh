#!/bin/bash
set -e

echo "Running smoke test..."

APP_URL=${APP_URL:-"http://localhost"}

echo "Checking $APP_URL..."

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "❌ Smoke test failed: Expected 200, got $HTTP_STATUS"
  exit 1
fi

echo "✅ Smoke test passed: App is reachable"
#!/bin/bash
set -e

APP_NAME="ecommerce-app"
TAG=${1:-latest}
REPO=$2   # full repo like balajiyuva/dev or balajiyuva/prod

if [ -z "$REPO" ]; then
  echo "❌ Usage: ./deploy.sh <tag> <repository>"
  echo "   Example: ./deploy.sh 5 balajiyuva/dev"
  exit 1
fi

echo "📦 Tagging image..."
docker tag $APP_NAME:$TAG $REPO:$TAG

echo "📤 Pushing image..."
docker push $REPO:$TAG

echo "✅ Successfully pushed to $REPO:$TAG"

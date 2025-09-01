#!/bin/bash
set -e

APP_NAME="ecommerce-app"
TAG=${1:-latest}
DOCKERHUB_USER="balajiyuva"
REPO=$2   # dev or prod

if [ -z "$REPO" ]; then
  echo "❌ Usage: ./deploy.sh <tag> <dev|prod>"
  exit 1
fi

echo "🔑 Logging into DockerHub..."
docker login -u $DOCKERHUB_USER

echo "📦 Tagging image..."
docker tag $APP_NAME:$TAG $DOCKERHUB_USER/$REPO:$TAG

echo "📤 Pushing image..."
docker push $DOCKERHUB_USER/$REPO:$TAG

echo "✅ Successfully pushed to $DOCKERHUB_USER/$REPO:$TAG"

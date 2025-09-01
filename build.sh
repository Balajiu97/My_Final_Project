#!/bin/bash
set -e

BRANCH=$1
BUILD_NUMBER=$2
DOCKER_USER=$3
DOCKER_PASS=$4
DEV_REPO=$5
PROD_REPO=$6

APP_NAME="ecommerce-app"

echo "🔨 Building Docker image..."
docker build -t $APP_NAME:$BUILD_NUMBER .

# Always create local image for deploy.sh
echo "📦 Image built: $APP_NAME:$BUILD_NUMBER"

if [ "$BRANCH" == "dev" ]; then
  echo "📤 Pushing to DEV repo..."
  docker tag $APP_NAME:$BUILD_NUMBER $DEV_REPO:$BUILD_NUMBER
  docker push $DEV_REPO:$BUILD_NUMBER
elif [ "$BRANCH" == "master" ]; then
  echo "📤 Pushing to PROD repo..."
  docker tag $APP_NAME:$BUILD_NUMBER $PROD_REPO:$BUILD_NUMBER
  docker push $PROD_REPO:$BUILD_NUMBER
else
  echo "⚠️ Branch $BRANCH not configured for push. Image available locally only."
fi

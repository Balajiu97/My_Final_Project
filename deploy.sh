#!/bin/bash
set -e

TAG=$1
REPO=$2

APP_NAME="ecommerce-app"

echo "📦 Preparing image for deployment..."
docker tag $APP_NAME:$TAG $REPO:$TAG

echo "✅ Image ready locally as $REPO:$TAG (already pushed during build stage)"

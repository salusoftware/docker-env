#!/bin/bash

cd /salusoftware/docker-env || exit 1

echo "➡️ Atualizando código..."
git pull origin main

echo "🔨 Buildando container..."
docker-compose build

echo "♻️ Subindo aplicação..."
docker-compose up -d
#!/bin/bash
docker stop fastapi-prod || true
docker rm fastapi-prod || true
docker run -d --name fastapi-prod -p 8080:80 your-dockerhub-username/fastapi-app:$BUILD_NUMBER
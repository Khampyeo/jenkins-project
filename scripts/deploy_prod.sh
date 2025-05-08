#!/bin/bash
docker stop fastapi-staging || true
docker rm fastapi-staging || true
docker run -d --name fastapi-staging -p 8000:80 your-dockerhub-username/fastapi-app:$BUILD_NUMBER
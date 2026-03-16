# DevOps Build Project

Production-ready deployment of the given React build using Docker, Jenkins, AWS EC2, Docker Hub, and Uptime Kuma monitoring.

## Project Structure

```bash
.
├── build/
├── Dockerfile
├── docker-compose.yml
├── build.sh
├── deploy.sh
├── Jenkinsfile
├── Jenkinsfile.dev
├── Jenkinsfile.prod
├── .gitignore
├── .dockerignore
├── screenshots/
└── README.md
Files and Purpose

build/ - provided application build files

Dockerfile - containerizes the application using Nginx

docker-compose.yml - local container run configuration

build.sh - builds the Docker image

deploy.sh - runs the container on port 80

Jenkinsfile - pipeline logic used during testing

Jenkinsfile.dev - Jenkins pipeline for dev branch

Jenkinsfile.prod - Jenkins pipeline for master branch

.gitignore - ignores unnecessary local files

.dockerignore - excludes unnecessary files from Docker build context

screenshots/ - project submission screenshots

README.md - project overview

Branch Flow

dev branch:

build image

push to Docker Hub dev repo

deploy to application server

master branch:

build image

push to Docker Hub prod repo

Docker Images

Dev: app19/devops-build-dev:latest

Prod: app19/devops-build-prod:latest

Deployment

Application URL: http://13.232.228.100

Jenkins URL: http://3.111.246.227:8080

Monitoring: Uptime Kuma on Jenkins EC2

Monitoring

Health monitoring configured using Uptime Kuma

Slack notification configured for application downtime
```

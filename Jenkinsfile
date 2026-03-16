pipeline {
    agent any

    environment {
        IMAGE_NAME_DEV = "app19/devops-build-dev:latest"
        IMAGE_NAME_PROD = "app19/devops-build-prod:latest"
        APP_SERVER_IP = "13.232.228.100"
        REPO_URL = "https://github.com/Akashpeter19/devops-build.git"
    }

    stages {
        stage('Checkout Dev Branch') {
            steps {
                git branch: 'dev',
                    credentialsId: 'github-creds',
                    url: "${REPO_URL}"
            }
        }

        stage('Check Branch') {
            steps {
                script {
                    env.GIT_BRANCH_NAME = sh(
                        script: "git rev-parse --abbrev-ref HEAD",
                        returnStdout: true
                    ).trim()
                    echo "Current branch is: ${env.GIT_BRANCH_NAME}"
                }
            }
        }

        stage('Build Dev Image') {
            when {
                expression { env.GIT_BRANCH_NAME == 'dev' }
            }
            steps {
                sh 'docker build -t devops-build:local .'
            }
        }

        stage('Push Dev Image') {
            when {
                expression { env.GIT_BRANCH_NAME == 'dev' }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag devops-build:local $IMAGE_NAME_DEV
                        docker push $IMAGE_NAME_DEV
                    '''
                }
            }
        }

        stage('Deploy Dev to App Server') {
            when {
                expression { env.GIT_BRANCH_NAME == 'dev' }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sshagent(credentials: ['app-server-ssh']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@$APP_SERVER_IP << EOF2
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker pull $IMAGE_NAME_DEV
                            docker rm -f devops-build-container || true
                            docker run -d --name devops-build-container -p 80:80 $IMAGE_NAME_DEV
EOF2
                        '''
                    }
                }
            }
        }
    }
}

pipeline {
    agent any

    environment {
        registryCredential = 'awscreds'
        appRegistry = "509494336850.dkr.ecr.us-east-1.amazonaws.com/dotnet-webapp-image"
        myprojectRegistry = "https://509494336850.dkr.ecr.us-east-1.amazonaws.com"
        cluster = "my-dotnet-wabapp-cluster"
        service = "my-dotnetcluster-service"
    }

    stages {
        stage('Fetch code') {
            steps {
                git branch: 'dev/taj', url: 'https://github.com/taj-DevOps/mps.git'
            }
        }

        stage('Build App Image') {
            steps {
                script {
                    dockerImage = docker.build("${appRegistry}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Upload App Image') {
            steps {
                script {
                    dockerImage.push("${BUILD_NUMBER}")
                    dockerImage.push('latest')
                }
            }
        }

        stage('Deploy to ECS') {
            steps {
                withAWS(credentials: 'awscreds', region: 'us-east-1') {
                    sh "aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment"
                }
            }
        }
    }
}


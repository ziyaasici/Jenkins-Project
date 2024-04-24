pipeline {
    agent any   
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        ECR_REPO = '621627302500.dkr.ecr.us-east-1.amazonaws.com'
    }
    stages {
        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/ziyaasici/Jenkins-Project.git'
        //     }
        // }
        stage('Create Infrastructure') {
            steps {
                dir('terraform-files') {
                    script {
                        sh(script: 'terraform init', returnStdout: true)
                        sh(script: 'terraform plan', returnStdout: true)
                        sh(script: 'terraform apply -auto-approve', returnStdout: true)
                    }
                }
            }
        }
        stage('Build Images') {
            steps {
                dir('apps/nodejs') {
                    script {
                        sh(script: 'docker build -t nodejs:v1 .', returnStdout: true)
                    }
                }
                dir('apps/react') {
                    script {
                        sh(script: 'docker build -t react:v1 .', returnStdout: true)
                    }
                }
                dir('apps/postgresql') {
                    script {
                        sh(script: 'docker build -t postgresql:v1 .', returnStdout: true)
                    }
                }
            }
        }
        stage('Push Images to ECR') {
            steps {
                script {
                    sh(script: 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPO}', returnStdout: true)
                    sh(script: 'docker tag nodejs:v1 ${ECR_REPO}/nodejs:v1', returnStdout: true)
                    sh(script: 'docker tag react:v1 ${ECR_REPO}/react:v1', returnStdout: true)
                    sh(script: 'docker tag postgresql:v1 ${ECR_REPO}/postgresql:v1', returnStdout: true)
                    sh(script: 'docker push ${ECR_REPO}/postgresql:v1', returnStdout: true)
                    sh(script: 'docker push ${ECR_REPO}/react:v1', returnStdout: true)
                    sh(script: 'docker push ${ECR_REPO}/nodejs:v1', returnStdout: true)
                }
            }
        }
    }
    // post {
    //     failure {
    //         dir('iac-files') {
    //             sh(script: 'terraform destroy -auto-approve', returnStdout: true)
    //         }
    //     }
    // }
}

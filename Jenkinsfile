pipeline {
    agent any   
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
    }
    stages {
        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/ziyaasici/Jenkins-Project.git'
        //     }
        // }
        stage('Create Infrastructure') {
            steps {
                dir('iac-files') {
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
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 621627302500.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker tag nodejs:v1 621627302500.dkr.ecr.us-east-1.amazonaws.com/nodejs/nodejs:v1'
                    sh 'docker tag react:v1 621627302500.dkr.ecr.us-east-1.amazonaws.com/react/react:v1'
                    sh 'docker tag postgresql:v1 621627302500.dkr.ecr.us-east-1.amazonaws.com/postgresql/postgresql:v1'
                    sh 'docker push 621627302500.dkr.ecr.us-east-1.amazonaws.com/postgresql/postgresql:v1'
                    sh 'docker push 621627302500.dkr.ecr.us-east-1.amazonaws.com/react/react:v1'
                    sh 'docker push 621627302500.dkr.ecr.us-east-1.amazonaws.com/nodejs/nodejs:v1'
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

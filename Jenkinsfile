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
                        sh 'docker build -t nodejs:v1 .'
                    }
                }
                dir('apps/react') {
                    script {
                        sh 'docker build -t react:v1 .'
                    }
                }
                dir('apps/postgresql') {
                    script {
                        sh 'docker build -t postgres:v1 .'
                    }
                }
            }
        }
        stage('Push Images to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 621627302500.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker push postgres:v1'
                    sh 'docker push react:v1'
                    sh 'docker push nodejs:v1'
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

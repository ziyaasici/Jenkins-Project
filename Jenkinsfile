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
                dir('nodejs') {
                    sh 'docker build -t ziyaasici/nodejs:v1 .'
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 621627302500.dkr.ecr.us-east-1.amazonaws.com'
                }
            }
        }
    }
    // post {
    //     always {
    //         dir('iac-files') {
    //             sh(script: 'terraform destroy -auto-approve', returnStdout: true)
    //         }
    //     }
    // }
}

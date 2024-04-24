pipeline {
    agent any
    
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    //     AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    // }

    stages {
        stage('AWS Integration'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS-Jenkins',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
                    // {
                    //     sh "aws s3 ls"
                    // }
            }
        }
        stage('Testing') {
            steps {
                echo "Testing"
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ziyaasici/Jenkins-Project.git'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('iac-files') {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('iac-files') {
                    script {
                        sh 'ls -al'
                        sh 'terraform plan'
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('iac-files') {
                    script {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Check Created S3s') {
            steps {
                    script {
                        sh 'aws s3 ls'
                    }
                }
            }
    }
}

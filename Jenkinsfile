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
                    {
                        sh "aws s3 ls"
                    }
            }
        }
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
        stage('Checking S3 Bucked if Created') {
            steps {
                script {
                    sh 'aws s3 ls'
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                dir('iac-files') {
                    script {
                        echo '!!!!!'
                        echo 'Everything worked as expected. Now deleting resources.'
                        echo '!!!!!'
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}

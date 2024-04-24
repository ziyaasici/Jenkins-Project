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
    }
    post {
        always {
            dir('iac-files') {
                sh(script: 'terraform destroy -auto-approve', returnStdout: true)
            }
        }
    }
}

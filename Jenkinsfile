pipeline {
    agent any   
    stages {
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

pipeline {
    agent { label 'Linux' } 
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        ECR_REPO = '621627302500.dkr.ecr.us-east-1.amazonaws.com'
        AWS_REGION = 'us-east-1'
        DOCKER_SERVER = 'Jenkins-Project-Docker'
    }
    stages {
        stage('Create Infrastructure') {
            steps {
                dir('terraform/terra-infra') {
                    script {
                        sh(script: 'aws ec2 create-key-pair --key-name DockerKey --region ${AWS_REGION} --query "KeyMaterial" --output text > DockerKey.pem', returnStdout: true) //  Existing Check Ekle
                        sh(script: 'sudo chmod 600 DockerKey.pem', returnStatus: true)
                        sh(script: 'terraform init', returnStdout: true)
                        sh(script: 'terraform plan', returnStdout: true)
                        sh(script: 'terraform apply -auto-approve', returnStdout: true)
                    }
                }
            }
        }
        stage('Create ECR') {
            steps {
                script {
                    createEcrRepositoryIfNotExists('nodejs')
                    createEcrRepositoryIfNotExists('react')
                    createEcrRepositoryIfNotExists('postgresql')
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
        stage('Wait') {
            steps {
                script {
                    def awsCommand = "aws ec2 describe-instances --filters Name=tag:Name,Values=${DOCKER_SERVER} Name=instance-state-name,Values=running --region ${AWS_REGION} --query 'Reservations[*].Instances[*].InstanceId' --output text"
                    
                    def instanceId = sh(script: awsCommand, returnStdout: true).trim()
                    println "EC2 Instance ID: ${instanceId}"
                    
                    def ec2State = ''
                    timeout(time: 10, unit: 'MINUTES') {
                        while (ec2State != 'running') {
                            def instanceStateCmd = "aws ec2 describe-instance-status --instance-ids ${instanceId} --region ${AWS_REGION} --query 'InstanceStatuses[0].InstanceState.Name' --output text"
                            ec2State = sh(script: instanceStateCmd, returnStdout: true).trim()
                            if (ec2State != 'running') {
                                println "EC2 instance is not running yet. Waiting..."
                                sleep time: 30, unit: 'SECONDS'
                            }
                        }
                    }
                }
            }
        }
        stage('Deploy App') {
            steps {
                // dir('Ansible') {
                //     script {
                //         sh(script: 'ansible-playbook playbook.yml', returnStdout: true)
                //     }
                // }
                dir('Ansible') {
                    ansiblePlaybook(
                        // playbook: 'path/to/your/playbook.yml',
                        // inventory: 'path/to/your/inventory',
                        extras: '-e AWS_ACCESS=${AWS_ACCESS} -e AWS_REGION=${AWS_REGION} -e ECR_REPO=${ECR_REPO}'
                    )
                }
            }
        }
    }
    post {
        failure {
            dir('terraform/terra-infra') {
                sh(script: 'aws ec2 delete-key-pair --key-name DockerKey', returnStdout: true)
                sh(script: 'terraform destroy -auto-approve', returnStdout: true)
            }
        }
    }

}

def createEcrRepositoryIfNotExists(repositoryName) {
    def exists = sh(script: "aws ecr describe-repositories --repository-names ${repositoryName}", returnStatus: true) == 0
    if (!exists) {
        sh(script: "aws ecr create-repository --repository-name ${repositoryName} --image-tag-mutability IMMUTABLE", returnStdout: true)
    } else {
        echo "ECR repository '${repositoryName}' already exists."
    }
}
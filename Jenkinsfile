pipeline {
    agent any   
    environment {
        AWS_ACCESS=credentials('AWS-Jenkins')
        ECR_REPO = '621627302500.dkr.ecr.us-east-1.amazonaws.com'
        AWS_REGION = 'us-east-1'
        DOCKER_SERVER = 'Jenkins-Project-Docker'
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
        // stage('Build Images') {
        //     steps {
        //         dir('apps/nodejs') {
        //             script {
        //                 sh(script: 'docker build -t nodejs:v1 .', returnStdout: true)
        //             }
        //         }
        //         dir('apps/react') {
        //             script {
        //                 sh(script: 'docker build -t react:v1 .', returnStdout: true)
        //             }
        //         }
        //         dir('apps/postgresql') {
        //             script {
        //                 sh(script: 'docker build -t postgresql:v1 .', returnStdout: true)
        //             }
        //         }
        //     }
        // }
        // stage('Push Images to ECR') {
        //     steps {
        //         script {
        //             sh(script: 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ECR_REPO}', returnStdout: true)
        //             sh(script: 'docker tag nodejs:v1 ${ECR_REPO}/nodejs:v1', returnStdout: true)
        //             sh(script: 'docker tag react:v1 ${ECR_REPO}/react:v1', returnStdout: true)
        //             sh(script: 'docker tag postgresql:v1 ${ECR_REPO}/postgresql:v1', returnStdout: true)
        //             sh(script: 'docker push ${ECR_REPO}/postgresql:v1', returnStdout: true)
        //             sh(script: 'docker push ${ECR_REPO}/react:v1', returnStdout: true)
        //             sh(script: 'docker push ${ECR_REPO}/nodejs:v1', returnStdout: true)
        //         }
        //     }
        // }
        stage('Wait') {
            steps {
                script {
                    def awsCommand = "aws ec2 describe-instances --filters Name=tag:Name,Values=${DOCKER_SERVER} --region ${AWS_REGION} --query 'Reservations[0].Instances[0].InstanceId' --output text"
                    
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
    }
    // post {
    //     always {
    //             echo 'Removing local images!..'
    //             sh(script: 'docker rmi -f $(docker images)', returnStdout: true)
    //         }
    //     }
}

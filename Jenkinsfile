pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
            withAWS(credentials: 'aws'){
                sh 'terraform init'
            }
            }
        }
        stage('terraform Plan') {
            steps{
            withAWS(credentials: 'aws') {
                sh 'terraform plan'
            }
            }
        }
        stage('terraform apply') {
            steps {
        withAWS(credentials: 'aws') {
            sh 'terraform apply --var-file=dev.tfvars --auto-approve'
        }
                
        }
     }
    }
}
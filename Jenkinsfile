pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('terraform format check') {
            steps{
                sh 'terraform -chdir=./terraform fmt'
            }
        }
        stage('terraform Init') {
            steps{
            withAWS(credentials: 'aws'){
                sh 'terraform -chdir=./terraform init'
            }
            }
        }
        stage('terraform Plan') {
            steps{
            withAWS(credentials: 'aws') {
                sh 'terraform -chdir=./terraform plan -var-file=dev.tfvars'
            }
            }
        }
        stage('terraform apply') {
            steps {
        withAWS(credentials: 'aws') {
            sh 'terraform -chdir=./terraform apply --var-file=dev.tfvars --auto-approve'
        }    
        }
     }
     stage('ansible prep') {
            steps {
        withAWS(credentials: 'aws'){
                sh 'terraform -chdir=./terraform output instance_public'
                sh 'chmod +x ./scripts/ips.sh'
                sh './scripts/ips.sh'
             }
                
        }
     }
    }
}
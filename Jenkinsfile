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
     stage('ssh_test') {
            steps {
            ansiblePlaybook( 
              playbook: './ansible/test.yml',
              inventory: './ansible/hosts', 
              credentialsId: 'ansible_ssh',
              become : true,
              becomeUser:'root',
              hostKeyChecking:false,
              installation:'ansible',
              colorized: true
              ) 
        }
     }
     stage('configure the slave instance') {
            steps {
                sh 'ansible-playbook -i ./ansible/hosts ./ansible/jenkins_slave.yml'                
        }
     }
     stage('configure bastion as proxy_server') {
            steps {
                sh 'ansible-playbook -i ./ansible/hosts  ./ansible/nginx_proxy.yml'   
        }
     }
    }
}
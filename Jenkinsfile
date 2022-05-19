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
     stage('ansible configure') {
            steps {
        withAWS(credentials: 'aws'){
                sh 'terraform -chdir=./terraform output instance_public'
                sh 'chmod +x ./scripts/ips.sh'
                sh './scripts/ips.sh'
                // sh 'sed -i "s#HostName.*#HostName $(terraform -chdir=./terraform output --raw instance_public)#" /var/jenkins_home/.ssh/config'
                // sh 'sed -i "s/.*ansible_host.*/ansible_host: $(terraform -chdir=./terraform output --raw instance_private)/" ./ansible/group_vars/slave'
                // sh 'sed -i "s#proxy_pass.*#proxy_pass http://$(terraform -chdir=./terraform output --raw instance_private):3000;#" ./ansible/files/nginx.conf'
             }
                
        }
     }
    }
}
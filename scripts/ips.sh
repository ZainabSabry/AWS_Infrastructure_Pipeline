#!/bin/bash
pwd
sed -i "s#HostName.*#HostName $(cat ./scripts/public_ip)#" /var/jenkins_home/.ssh/config
sed -i "s/.*ansible_host.*/ansible_host: $(cat ./scripts/private_ip)/" ../ansible/group_vars/slave      
sed -i "s#proxy_pass.*#proxy_pass http://$(cat ./scripts/private_ip):3000;#" ../ansible/files/nginx.conf










# sed -i 's#HostName.*#HostName ${self.public_ip}#' /var/jenkins_home/.ssh/config
# sed -i 's/.*ansible_host.*/ansible_host: ${self.private_ip}/' ../ansible/group_vars/slave      
# sed -i 's#proxy_pass.*#proxy_pass http://${self.private_ip}:3000;#' ../ansible/files/nginx.conf
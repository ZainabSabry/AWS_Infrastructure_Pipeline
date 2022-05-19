resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id              = module.network.public_1_id
  # key_name               = aws_key_pair.public_key_pair.key_name
  key_name               = "redhat"

  tags = {
    Name = "${var.name}-bastion"
  }

  provisioner "local-exec" {
    command = "sed -i 's/.*public.*/public ansible_host=${self.public_ip}/' ./ansible/hosts"
    
  }
}


resource "aws_instance" "application" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = module.network.private_1_id
  # key_name               = aws_key_pair.public_key_pair.key_name
  key_name               = "redhat"

  tags = {
    Name = "${var.name}-application"
  }

  provisioner "local-exec" {
    command = "sed -i 's/.*ansible_host.*/ansible_host: ${self.private_ip}/' ./ansible/group_vars/slave"
    
  }

}




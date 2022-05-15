resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id              = module.network.public_1_id
  # key_name               = aws_key_pair.public_key_pair.key_name

  tags = {
    Name = "${var.name}-bastion"
  }

  provisioner "local-exec" {
    command = "echo the public IP of bastion ${self.public_ip} > provisioner.txt"
  }
}


resource "aws_instance" "application" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.private.id]
  subnet_id              = module.network.private_1_id
  # key_name               = aws_key_pair.public_key_pair.key_name

  tags = {
    Name = "${var.name}-application"
  }
}




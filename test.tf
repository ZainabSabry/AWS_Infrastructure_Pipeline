resource "aws_instance" "test" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  subnet_id = "subnet-02d8a92c77c22595f"
  key_name = "redhat.pem"

  root_block_device {
        delete_on_termination = true
        encrypted             = false
        volume_size           = 8
        volume_type           = "gp2"
    }


  tags = {
    Name = "test"
  }
}

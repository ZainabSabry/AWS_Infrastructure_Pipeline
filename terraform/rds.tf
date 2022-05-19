resource "aws_db_subnet_group" "terra-subnet-group" {
  name       = "terra-subnet-group"
  subnet_ids = [module.network.private_1_id, module.network.private_2_id]

  tags = {
    Name = "My Terra DB subnet group"
  }
}


resource "aws_db_instance" "terra-rds" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "password123456789"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.terra-subnet-group.name
}
resource "aws_db_instance" "main" {
  allocated_storage    = var.allocated_storage    
  db_name              = var.db_name              
  engine               = var.engine               
  engine_version       = var.engine_version       
  instance_class       = var.instance_class       
  username             = var.username             
  password             = var.password             
  parameter_group_name = var.parameter_group_name 
  skip_final_snapshot  = var.skip_final_snapshot
  availability_zone    = var.rds_instance_az
  multi_az             = false
  db_subnet_group_name = var.rds_subnet_group_id

  vpc_security_group_ids = [var.db_security_group_name]
  tags = {
    Name = "main"
  }
}

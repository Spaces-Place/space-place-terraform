resource "aws_security_group" "web-sg" {
  vpc_id      = var.sp-vpc-id
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-sp-sg-web"
    Environment = var.environment
    Project     = var.tags["Project"]
    Owner       = var.tags["Owner"]
  }
}

resource "aws_security_group" "rds-sg" {
  vpc_id = var.sp-vpc-id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  tags = {
    Name        = "${var.environment}-sp-rds-sg"
    Environment = var.environment
    Project     = var.tags["Project"]
    Owner       = var.tags["Owner"]
  }
}

resource "aws_security_group" "document-sg" {
  vpc_id = var.sp-vpc-id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  tags = {
    Name        = "${var.environment}-sp-document-sg"
    Environment = var.environment
    Project     = var.tags["Project"]
    Owner       = var.tags["Owner"]
  }
}

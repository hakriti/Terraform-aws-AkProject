resource "aws_security_group" "beanstalk-sg" {
  name        = "beanstalk-sg"
  description = "Allow tcp from beanstalk"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TCP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastionhost-sg" {
  name        = "bastionhost-sg"
  description = "Allow ssh "
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TCP "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.MYIP]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "EC2instance_sg" {
  name        = "EC2instance_sg"
  description = "For ec2 instance in beanstalk environment"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TCP "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_security_group.bastionhost-sg.id]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Backend-sg" {
  name        = "Backend-sg"
  description = "For backend RDS Elastic cache and activemq"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TCP"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_security_group.EC2instance_sg.id]
    
  }
ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_security_group.bastionhost-sg.id]
    
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "security_allow_itself" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.Backend-sg.id
  source_security_group_id = aws_security_group.Backend-sg.id
}

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds_subnet"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]]

  tags = {
    Name = "Subnet group for RDS"
  }
}


resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name       = "elasticache_subnet"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1],module.vpc.private_subnets[2]]

  tags = {
    Name = "Subnet group for elasticacahe"
  }
}
resource "aws_db_instance" "egproject_RDS" {
  allocated_storage    = 1
  db_name              = var.dbname
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.dbuser
  password             = var.dbpass
  parameter_group_name = "default.mysql5.7"
 multi_az              = "false"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.Backend-sg.id]
}


resource "aws_elasticache_cluster" "elasticache" {
  cluster_id           = "elasticache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
 subnet_group_name = aws_elasticache_subnet_group.elasticache_subnet.name
  security_group_ids = [aws_security_group.Backend-sg.id]
}

resource "aws_mq_broker" "Activemq" {
  broker_name = "Activemq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.9"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.Backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    username = var.akuser
    password = var.akuser
  }
}

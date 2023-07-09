resource "aws_instance" "vprofile-bastion" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.egprojectkey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.bastionhost-sg.id]

  tags = {
    Name    = "egproject-bastion"
    PROJECT = "egproject"
  }

  provisioner "file" {
    content     = templatefile("db-deploy.tmpl", { rds-endpoint = aws_db_instance.egproject_RDS.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/egproject-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/egproject-dbdeploy.sh",
      "sudo /tmp/egproject-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.egproject_RDS]
}

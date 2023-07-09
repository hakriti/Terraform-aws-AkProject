variable "REGION" {
  default = "eu-west-2"
}

variable "AMIS" {
  type = map(any)
  default = {
    eu-west-2 = "ami-0eb260c4d5475b901"
    us-east-2 = "ami-024e6efaf93d85776"
    eu-west-1 = "ami-01dd271720c1ba44f"
  }
}

variable "PRIV_KEY_PATH" {
  default = "egprojectkey"
}

variable "PUB_KEY_PATH" {
  default = "egprojectkey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "183.83.39.124/32"
}

variable "akuser" {
  default = "Activemqawsqr"
}

variable "akpass" {
  default = "Qwerty@12345689"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "AAsdfgh@123456"
}

variable "dbname" {
  default = "egprojectdb"
}

variable "instance_count" {
  default = 1
}

variable "VPC_NAME" {
  default = "egproject=VPC"
}

variable "ZONE1" {
  default = "eu-west-2a"
}

variable "ZONE2" {
  default = "eu-west-2b"
}

variable "ZONE3" {
  default = "eu-west-2c"
}

variable "VpcCIDR" {
  default = "172.20.0.0/16"
}

variable "PUBsubnetCIDER1" {
  default = "172.20.1.0/24"
}

variable "PUBsubnetCIDER2" {
  default = "172.20.2.0/24"
}

variable "PUBsubnetCIDER3" {
  default = "172.20.3.0/24"
}

variable "PRIVsubnetCIDER1" {
  default = "172.20.4.0/24"
}

variable "PRIVsubnetCIDER2" {
  default = "172.20.5.0/24"
}

variable "PRIVsubnetCIDER3" {
  default = "172.20.6.0/24"
}



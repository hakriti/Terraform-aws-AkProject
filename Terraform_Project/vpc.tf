module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VpcCIDR

  azs             = [var.ZONE1,var.ZONE2,var.ZONE3]
  private_subnets = [var.PRIVsubnetCIDER1, var.PRIVsubnetCIDER2, var.PRIVsubnetCIDER3]
  public_subnets  = [var.PUBsubnetCIDER1 , var.PUBsubnetCIDER2 , var.PUBsubnetCIDER3]

  enable_nat_gateway = true
  single_nat_gateway  = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "Live"
  }
vpc_tags = {
   Name = var.VPC_NAME
}
}

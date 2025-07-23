module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  ...
  enable_classiclink = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support
  ...
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }

  tags = { Environment = "dev" }
}

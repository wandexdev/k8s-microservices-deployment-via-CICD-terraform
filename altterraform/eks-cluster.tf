#-----------provider to communicate with Kubernetes’ resources----------#

provider "kubernetes" {
    host                        = data.aws_eks_cluster.wandek8s-eks-cluster.endpoint # end point of k8s (API server)
    token                       = data.aws_eks_cluster_auth.wandek8s-eks-cluster.token
    cluster_ca_certificate      = base64decode(data.aws_eks_cluster.wandek8s-eks-cluster.certificate_authority.0.data)
}

#--------Query data ------------#
data "aws_eks_cluster" "wandek8s-eks-cluster" {
    name                        = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "wandek8s-eks-cluster" {
    name                        = module.eks.cluster_id
}

module "eks" {
  source                        = "terraform-aws-modules/eks/aws"
  version                       = "19.10.0"

  cluster_name                  = "wandek8s-eks-cluster"
  cluster_version               = "1.24"

  subnet_ids                    = module.wandek8s-vpc.private_subnets
  vpc_id                        = module.wandek8s-vpc.vpc_id

  tags = {
      environment = "development"
      application = "wandek8s"
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 4
      desired_size = 3

      instance_types = var.instance_type
    }
  }
}

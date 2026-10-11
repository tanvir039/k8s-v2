module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name    = "${var.project_name}-${var.environment}"
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # No public subnets exist, so nodes/pods live entirely in private subnets.
  # Public endpoint access lets you run kubectl from your laptop without a
  # bastion/VPN; private access lets in-cluster components (ArgoCD, etc.)
  # reach the API server without leaving the VPC.
  endpoint_public_access  = true
  endpoint_private_access = true

  # Automatically grants your current IAM identity (whoever runs terraform
  # apply) cluster-admin via EKS access entries - no separate aws-auth
  # configmap editing needed to get kubectl working.
  enable_cluster_creator_admin_permissions = true

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }

    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = aws_iam_role.ebs_csi.arn
    }
  }

  eks_managed_node_groups = {
    system = {
      name           = "system"
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      min_size     = 1
      max_size     = 3
      desired_size = 2

      subnet_ids = module.vpc.private_subnets

      labels = {
        role = "system"
      }

      tags = local.common_tags
    }
  }

  tags = local.common_tags
}
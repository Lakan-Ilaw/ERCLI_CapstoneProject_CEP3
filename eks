module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"
  enable_irsa = false
  
  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true
  iam_role_additional_policies = {
    additional = aws_iam_policy.additional.arn
  }

  cluster_addons = {
    coredns = {
      most_recent = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    kube-proxy = {
      most_recent = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    vpc-cni = {
      most_recent              = true
      before_compute           = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = { 
	ami_type                              = "AL2_x86_64"
    instance_types                        = ["t2.micro"]
    attach_cluster_primary_security_group = true
    vpc_security_group_ids                = [aws_security_group.sec_group.id]
	iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
  }

  eks_managed_node_groups = {
	ercli_eks_nodes = {
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = ["t2.micro"]
      capacity_type  = "SPOT"
  
      update_config = {
        max_unavailable = 1
      }
    }
  }

}

resource "aws_iam_policy" "additional" {
  name = "${var.cluster_name}-additional"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_autoscaling_policy" "node-autoscaling" {
  name                   = "node-autoscaling"
  autoscaling_group_name = module.eks.eks_managed_node_groups.eks_nodes.node_group_autoscaling_group_names[0]
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 30

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}

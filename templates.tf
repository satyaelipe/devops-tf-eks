data "template_file" "kubeconfig_aws_eks_get_token" {
  template = file("${path.root}/templates/kubeconfig.aws_eks_get_token.tpl")
  vars = {
    cluster_name              = local.cluster_name
    endpoint                  = aws_eks_cluster.eks-cluster.endpoint
    certificate_authority_data= aws_eks_cluster.eks-cluster.certificate_authority.0.data
  }
}

data "template_file" "kubeconfig_heptio" {
  template = file("${path.root}/templates/kubeconfig.heptio.tpl")
  vars = {
    cluster_name              = local.cluster_name
    endpoint                  = aws_eks_cluster.eks-cluster.endpoint
    certificate_authority_data= aws_eks_cluster.eks-cluster.certificate_authority.0.data
  }
}

data "template_file" "kubeconfig_iam_aws_authenticator" {
  template = file("${path.root}/templates/kubeconfig.iam_aws_authenticator.tpl")
  vars = {
    cluster_name              = local.cluster_name
    endpoint                  = aws_eks_cluster.eks-cluster.endpoint
    certificate_authority_data= aws_eks_cluster.eks-cluster.certificate_authority.0.data
  }
}

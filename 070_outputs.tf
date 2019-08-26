
output "kubeconfig_aws_eks_get_token" {
  value = "${data.template_file.kubeconfig_aws_eks_get_token.rendered}"
}

output "kubeconfig_heptio" {
  value = "${data.template_file.kubeconfig_heptio.rendered}"
}

output "kubeconfig_iam_aws_authenticator" {
  value = "${data.template_file.kubeconfig_iam_aws_authenticator.rendered}"
}


//Required Kubernetes Configuration to Join Worker Nodes
//The EKS service does not provide a cluster-level API parameter or resource to automatically configure the underlying
//Kubernetes cluster to allow worker nodes to join the cluster via AWS IAM role authentication.


//To output an IAM Role authentication ConfigMap from your Terraform configuration:

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.EKSNodeRole.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}


//Run
//
//terraform output config-map-aws-auth and save the configuration into a file,
//e.g. config-map-aws-auth.yaml
//
//Run kubectl apply -f config-map-aws-auth.yaml
//
//You can verify the worker nodes are joining the cluster via: kubectl get nodes --watch
//At this point, you should be able to utilize Kubernetes as expected!
//


output "cluster_id" {
  description = "The name of the cluster."
  value       = aws_eks_cluster.eks-cluster.id
}

output "cluster_arn" {
  description = "The ARN of the cluster."
  value       = aws_eks_cluster.eks-cluster.arn
}

output "cluster_certificate_authority_data" {
  description = "base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = aws_eks_cluster.eks-cluster.version
}

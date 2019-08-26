//
//EKS Master Cluster
//This resource is the actual Kubernetes master cluster. It can take a few minutes to provision in AWS.



resource "aws_eks_cluster" "eks-cluster" {
  name     = "${local.cluster_name}"
  role_arn = "${aws_iam_role.EKSClusterRole.arn}"
  version = "${var.KUBERNETES_VERSION}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eks-control-plane-sg.id}"]

    subnet_ids = [
      "${aws_subnet.eks-private.id}",
      "${aws_subnet.eks-private-2.id}"
    ]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-policy-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.eks-policy-AmazonEKSServicePolicy",
  ]
}

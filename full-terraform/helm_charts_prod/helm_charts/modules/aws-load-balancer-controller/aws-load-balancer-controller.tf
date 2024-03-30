resource "helm_release" "aws-load-balancer-controller" {
    name = "aws-load-balancer"
    chart = "eks/aws-load-balancer-controller"
    namespace = "kube-system"
    set {
      name = "clusterName"
      value = var.cluster_name
    }
}
resource "helm_release" "aws-ebs-csi-driver" {
    name       = "aws-ebs-csi-driver"
    chart      = "aws-ebs-csi-driver/aws-ebs-csi-driver"
    namespace  = "kube-system"
}
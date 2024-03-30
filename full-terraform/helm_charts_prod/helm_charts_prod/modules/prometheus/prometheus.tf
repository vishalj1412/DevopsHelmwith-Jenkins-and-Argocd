resource "helm_release" "kube-prometheus-stack" {
    name = "prometheus-stack"
    chart = "prometheus-community/kube-prometheus-stack"
    create_namespace = true
    namespace = "monitoring"
}


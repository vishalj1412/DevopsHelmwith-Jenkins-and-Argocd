resource "helm_release" "metric_server" {
    name = "metric-server"
    chart = "metrics-server/metrics-server"
    namespace = "kube-system"

}
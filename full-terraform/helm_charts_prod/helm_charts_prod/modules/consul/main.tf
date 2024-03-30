resource "helm_release" "consul" {
  name = "consul"
  create_namespace = true
  namespace = "consul"
  chart = "hashicorp/consul"
  values = [
          file("${path.module}/values.yaml")
           ]
  # set {
  #   name = "meshGateway.service.type"
  #   value = "ClusterIP"
  # }

  # set {
  #   name = "global.acls.manageSystemACLs"
  #   value = true
  # }
  # set {
  #   name = "client.enable"
  #   value = true
  # }
  # set {
  #   name = "connectInject.enable"
  #   value = true
  # }
  # set {
  #   name = "ui.enabled"
  #   value = true
  # }
  # set {
  #   name = "ui.service.type"
  #   value = "ClusterIP"
  # }
  # set {
  #   name = "controller.enable"
  #   value = true
  # }
  # set {
  #   name = "server.replicas"
  #   value = 1
  # }
  # set {
  #   name = "global.metrics.enaled"
  #   value = true
  # }
  # set {
  #   name = "global.metrics.enableAgentMetrics"
  #   value = true
  # }
  # set {
  #   name = "global.metrics.agentMetricsRetentionTime"
  #   value = "1m"
  # }
  # set {
  #   name = "ui.metrics.enabled"
  #   value = true
  # }
  # set {
  #   name = "ui.metrics.provider"
  #   value = "prometheus"
  # }
  # set {
  #   name = "ui.metrics.baseURL"
  #   value = "http://prometheus-server.consul.svc.cluster.local"
  # }
  # set {
  #   name = "connectInject.metrics.defaultEnabled"
  #   value = true
  # }
  # set {
  #   name = "connectInject.metrics.defaultEnableMerging"
  #   value = true
  # }
}
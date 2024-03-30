resource "helm_release" "argocd" {
  name = "argocd"
  chart = "argo/argo-cd"
  create_namespace = true
  namespace = "argocd"

  set {
    name = "redis-ha.enabled"
    value = true
  }
  set {
    name = "repoServer.autoscaling.enabled"
    value = true
  }
  set {
    name = "server.autoscaling.enabled"
    value = true
  }
}

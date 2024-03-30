resource "helm_release" "this" {
	name = "cluster-autoscalar"
	chart = "stable/cluster-autoscaler"
	namespace = "kube-system"

	set {
	  name = "autoDiscovery.clusterName"
	  value = var.cluster_name
	}

}
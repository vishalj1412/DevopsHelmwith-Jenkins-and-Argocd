resource "helm_release" "this" {
	name = "cluster-autoscalar"
	chart = "autoscaler/cluster-autoscaler"
	namespace = "kube-system"

	set {
	  name = "autoDiscovery.clusterName"
	  value = var.cluster_name
	}
	set {
	  name = "image.tag"
	  value = "v1.24.2"
	}

}
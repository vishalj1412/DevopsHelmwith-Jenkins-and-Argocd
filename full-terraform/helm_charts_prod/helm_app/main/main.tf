### ALB Ingress Controller ###
module "aws-load-balancer-controller" {
  source = "../modules/aws-load-balancer-controller"
  cluster_name = var.cluster_name
}

### ArgoCD ###
module "argocd" {
  source = "../modules/argocd"
}

### Cluster Autoscaler ###


## Consul ###
module "consul" {
  source = "../modules/consul"
}

### EBS CSI DRIVER ###
module "ebs_csi" {
    source = "../modules/ebs_csi"
}


### KONG ###
module "kong" {
  depends_on = [ module.consul ]
  source      = "../modules/kong"
  db_database = var.db_database
  db_host     = var.db_host
  db_password = var.db_password
  db_port     = var.db_port
  db_user     = var.db_user
}

## Metric Server ###
module "metric_server" {
    source = "../modules/metric_server"
}

### Prometheus ###
module "prometheus" {
    source = "../modules/prometheus"
}

module "elk" {
  source = "../modules/elk"
}

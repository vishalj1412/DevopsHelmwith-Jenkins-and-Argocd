resource "helm_release" "elasticsearch" {
   name = "elasticsearch"
   chart = "elastic/elasticsearch"
   #create_namespace = true
   namespace = "logging"
   set {
     name = "replicas"
     value = 2
   }
   set {
     name = "volumeClaimTemplate.resources.requests.storage"
     value = "100Gi"
   }
   set {
     name = "resources.requests.cpu"
     value = "500m"
   }
   set {
     name = "resources.requests.memory"
     value = "1Gi"
   }
}

resource "helm_release" "kibana" {
   depends_on = [ helm_release.elasticsearch ]
   name = "kibana"
   chart = "elastic/kibana"
   namespace = "logging"
   set {
     name = "service.port"
     value = 80
   }
   set {
     name = "resources.requests.cpu"
     value = "500m"
   }
   set {
     name = "resources.requests.memory"
     value = "1Gi"
   }

}
resource "helm_release" "filebeat" {
   depends_on = [ helm_release.elasticsearch, helm_release.kibana ]
   name = "filbeat"
   chart = "elastic/filebeat"
   namespace = "logging"
}
resource "helm_release" "kong" {
    name = "kong"
    create_namespace = true
    namespace = "kong"
    chart = "kong/kong"
    # values = [
    #       file("${path.module}/kong.yaml")
    #        ]
    set {
      name = "ingressController.installCRDs"
      value = false
    }
    set {
      name = "env.database"
      value = "postgres"
    }
    set {
      name = "env.pg_host"
      value = var.db_host
    }
    set {
      name = "env.pg_port"
      value = var.db_port
    }
    set {
      name = "env.pg_user"
      value = var.db_user
    }
    set {
      name = "env.pg_password"
      value = var.db_password
    }
    set {
      name = "env.pg_database"
      value = var.db_database
    }
    set {
      name = "env.ADMIN_GUI_PATH"
      value = "/manager"
    }
    set {
      name = "env.ADMIN_GUI_URL"
      value = "http://localhost:8002/manager"
    }
    set {
      name = "admin.enabled"
      value = true
    }
    set {
      name = "admin.http.enabled"
      value = true
    }
    set {
      name = "proxy.type"
      value = "ClusterIP"
    }
}

resource "helm_release" "konga" {
    name      = "konga"
    namespace = "kong"
    chart     = "C:\\Users\\adnan.khan\\truemeds\\konga-master\\charts\\konga"
}
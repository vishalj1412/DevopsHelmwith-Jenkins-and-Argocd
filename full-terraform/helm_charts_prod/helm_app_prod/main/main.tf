

### KONG ###
module "kong" {
 # depends_on = [ module.consul ]
  source      = "../modules/kong"
  db_database = var.db_database
  db_host     = var.db_host
  db_password = var.db_password
  db_port     = var.db_port
  db_user     = var.db_user
}
module "elk" {
  source = "../modules/elk"
}
## Metric Server ###



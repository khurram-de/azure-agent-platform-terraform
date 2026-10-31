# Platform module (called once)
module "platform" {
  source = "../../modules/agent-platform"

  location           = var.location
  environment        = var.environment
  project_name       = "agent-platform"
  log_retention_days = 30
  log_daily_quota_gb = 1

  tags = {
    project     = "azure-agent-platform"
    environment = var.environment
    managed_by  = "terraform"
  }
}


module "agents" {
  source   = "../../modules/agent-workload"
  for_each = var.agents

  agent_name = each.key

  resource_group_name           = module.platform.resource_group_name
  location                      = module.platform.location
  container_apps_environment_id = module.platform.container_apps_environtment_id

  container_image     = each.value.container_image
  cpu                 = each.value.cpu
  memory              = each.value.memory
  min_replicas        = each.value.min_replicas
  max_replicas        = each.value.max_replicas
  ingress_enabled     = each.value.ingress_enabled
  ingress_target_port = each.value.ingress_target_port

  tags = {
    project    = "azure-agent-platform"
    enviroment = var.environment
    managed_by = "terraform"
    agent      = each.key
  }
}


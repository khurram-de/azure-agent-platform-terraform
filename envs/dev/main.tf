module "platform" {
    source = "../../modules/agent-platform"

    location = var.location
    environment = var.environment
    project_name = "agent-platform"
    log_retention_days = 30
    log_daily_quota_gb = 1

    tags = {
        project = "azure-agent-platform"
        environment = var.environment
        managed_by = "terraform"
    }
}
variable "location" {
  description = "Azure region for workspace"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging or prod"
  }
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "agent-platform"
}

variable "log_retention_days" {
  description = "Log Analytics workspace retention in days"
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 30 && var.log_retention_days <= 730
    error_message = "Retention period must be between 30 and 730"
  }
}


variable "log_daily_quota_gb" {
  description = "Daily quota of log generation"
  type        = number

  validation {
    condition     = var.log_daily_quota_gb >= 1 && var.log_daily_quota_gb <= 100
    error_message = " Daily quota must be between 1 and 100 GB."
  }
}

variable "tags" {
  description = "Tags for different resources"
  type        = map(string)

  validation {
    condition     = contains(keys(var.tags), "environment") && contains(keys(var.tags), "project")
    error_message = "Tag must include 'environment' and 'project' keys."
  }
}
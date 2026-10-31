variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}


variable "agents" {
  description = "Map of agents to deploy"
  type = map(object({
    container_image     = string
    cpu                 = number
    memory              = string
    min_replicas        = number
    max_replicas        = number
    ingress_enabled     = bool
    ingress_target_port = number
  }))
}

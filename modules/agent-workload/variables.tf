variable "agent_name" {
  description = "Name of the agent, to be used for resource naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.agent_name))
    error_message = "Agent name can only contain lowercase alphanumeric or hyphen only"
  }
}

variable "location" {
  description = "Azure region for resource"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group (from platform module)"
  type        = string
}

variable "container_apps_environment_id" {
  description = "ID of the Container Apps environment (from platform module)"
  type        = string
}


variable "container_image" {
  description = "Container image to run"
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "cpu" {
  description = "CPU cores( 0.25, 0.5, .... , 2.0)"
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "memory in Gi (0.5, 1.0, 1.5, 2.0, 3.0, 3.5, 4.0)"
  type        = string
  default     = "1Gi"
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 3
}

variable "ingress_enabled" {
  description = "Enable external ingress (HTTPs endpoint)"
  type        = bool
  default     = true
}

variable "ingress_target_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
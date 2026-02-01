variable "location" {
  default = "eastus"
}

variable "resource_group_name" {
  default = "ts-poc-rg"
}

variable "tailscale_auth_key" {
  description = "YOUR TAILSCALE AUTH KEY"  #Update this
  sensitive   = true
}

variable "admin_username" {
  default = "azureuser"
}

variable "ssh_public_key" {
  description = "YOUR KEY HERE"  #update this
}

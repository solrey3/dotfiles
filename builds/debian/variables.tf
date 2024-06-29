variable "digitalocean_token" {
  description = "The token to access the DigitalOcean API"
}

variable "ssh_private_key_path" {
  description = "The path to the SSH private key file"
  default     = "~/.ssh/id_ed25519"
}

variable "vpc_uuid" {
  description = "The UUID of the VPC where the droplet will be created"
}



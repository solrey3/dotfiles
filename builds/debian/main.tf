provider "digitalocean" {
  token = var.digitalocean_token
}

variable "digitalocean_token" {}

variable "ssh_private_key_path" {
  description = "The path to the SSH private key file"
  default     = "~/.ssh/id_ed25519"
}

variable "vpc_uuid" {
  description = "The UUID of the VPC where the droplet will be created"
}

resource "digitalocean_droplet" "workstation" {
  image    = "debian-12-x64"
  name     = "workstation"
  region   = "nyc3"
  size     = "s-2vcpu-4gb-120gb-intel"
  vpc_uuid = var.vpc_uuid

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = self.ipv4_address
    }

    inline = [
      "apt-get update",
      "apt-get install -y sudo",
      "curl -O https://raw.githubusercontent.com/solrey3/dotfiles/main/builds/debian/setup.sh",
      "chmod +x setup.sh",
      "./setup.sh"
    ]
  }
}

output "droplet_ip" {
  value = digitalocean_droplet.workstation.ipv4_address
}



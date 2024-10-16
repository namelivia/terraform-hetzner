terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "=1.48.1"
    }
  }
}

resource "hcloud_ssh_key" "deployer" {
  name   = "${var.server_name}-key"
  public_key = "${var.ssh_key}"

}

resource "hcloud_server" "server" {
  name        = "${var.server_name}"
  image       = "ubuntu-24.04"
  datacenter = "fsn1-dc14"
  server_type = "${var.server_type}"
  ssh_keys    = [hcloud_ssh_key.deployer.id]
  public_net {
    ipv4_enabled = true
  }
}

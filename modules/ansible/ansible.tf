


resource "openstack_compute_instance_v2" "ansible" {
  name      = "ansible"
  flavor_id = var.flaver
  image_id  = var.image_id


  key_pair = var.admin_public_key

  network {
    name = var.network_name

  }

  user_data = templatefile("${path.module}/installation.sh",{
    private_key = var.private_key
    http_proxy  = var.http_proxy
    masterips   = var.masterips
    workerips   = var.workerips

  })



  security_groups = ["k8s_secgroup"]
}

output "user_data" {
  value = templatefile("${path.module}/installation.sh",{
    private_key = "var.private_key"
    http_proxy  = "var.http_proxy"
    masterips   = "var.masterips"
    workerips   = "var.workerips"

  })

}


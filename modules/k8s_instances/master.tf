resource "openstack_compute_instance_v2" "k8s-master" {
  name      = "k8s-master-${count.index}"
  flavor_id = var.flavers.master
  count     = var.master_vm_count
  image_id  = var.image_id
  scheduler_hints {
    group = openstack_compute_servergroup_v2.master.id
  }


  key_pair = var.ansible_key

  network {
    name = var.network.name

  }
  security_groups = ["k8s_secgroup"]
}
output "master_ips" {
  value = join(" ", "${openstack_compute_instance_v2.k8s-master.*.access_ip_v4}")

}
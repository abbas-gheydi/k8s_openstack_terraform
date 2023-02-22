resource "openstack_compute_instance_v2" "k8s-workers" {
  name      = "k8s-worker-${count.index}"
  flavor_id = var.flavers.worker
  count     = var.worker_vm_count
  image_id  = var.image_id


  scheduler_hints {
    group = openstack_compute_servergroup_v2.worker.id
  }

  key_pair = var.ansible_key


  network {
    name = var.network.name

  }
  security_groups = ["k8s_secgroup"]
}

output "works_ips" {
  value = join(" ", "${openstack_compute_instance_v2.k8s-workers.*.access_ip_v4}")

}
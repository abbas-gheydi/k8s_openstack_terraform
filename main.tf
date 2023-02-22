module "ansible" {
  source              = "./modules/ansible"
  private_key         = tostring(tls_private_key.ansible.private_key_openssh)
  http_proxy          = ""
  admin_public_key    = var.admin_pubick_key
  network_name        = var.network.name
  image_id            = var.image_id
  masterips           = module.k8s_instances.master_ips
  workerips           = module.k8s_instances.works_ips
  firewall_trusted_ip = var.firewall_trusted_ip
  flaver              = var.flavers.ansible


}
module "k8s_instances" {
  source              = "./modules/k8s_instances"
  admin_pubick_key    = var.admin_pubick_key
  flavers             = var.flavers
  image_id            = var.image_id
  network             = var.network
  master_vm_count     = var.master_vm_count
  worker_vm_count     = var.worker_vm_count
  firewall_trusted_ip = var.firewall_trusted_ip

}

output "msg" {
  value = "all instacnes are deployed. you can ssh to ansible vm and check /var/log/k8s_install.log and also you can run /kubespray/install.sh manually if needed."
  
}

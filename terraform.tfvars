tenant_name = "kubernetes"
admin_pubick_key = "admin"
image_id = "fd43748b-0128-45d5-9345-27bc921dc094"
flavers = {
  ansible = "50001"
  master = "50001"
  worker = "50001"
}
master_vm_count = 3
worker_vm_count = 3
firewall_trusted_ip = "10.0.0.0/8"
network = {
  name = "k8s_network"
  subnet_cidr = "10.2.1.0/24"
}

resource "tls_private_key" "ansible" {
  algorithm = "RSA"
  rsa_bits  = 3072
}
resource "openstack_compute_keypair_v2" "ansible" {
  name       = "${var.tenant_name}-ansible"
  public_key = tls_private_key.ansible.public_key_openssh


}
output "private_key" {
  value     = tls_private_key.ansible.private_key_openssh
  sensitive = true
}

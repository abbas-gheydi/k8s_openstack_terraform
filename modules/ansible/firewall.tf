resource "openstack_networking_secgroup_v2" "ansible_secgroup" {
  name        = "ansible_secgroup"
  description = "ansible security group"
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.firewall_trusted_ip
  security_group_id = openstack_networking_secgroup_v2.ansible_secgroup.id
}


resource "openstack_networking_secgroup_rule_v2" "allow_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = var.firewall_trusted_ip
  security_group_id = openstack_networking_secgroup_v2.ansible_secgroup.id
}
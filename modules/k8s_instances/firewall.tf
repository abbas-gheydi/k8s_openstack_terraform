resource "openstack_networking_secgroup_v2" "k8s_secgroup" {
  name        = "k8s_secgroup"
  description = "kubernetes security group"
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.firewall_trusted_ip
  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
}
resource "openstack_networking_secgroup_rule_v2" "allow_kubectl" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = var.firewall_trusted_ip
  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
}
resource "openstack_networking_secgroup_rule_v2" "allow_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = var.firewall_trusted_ip
  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
}


resource "openstack_networking_secgroup_rule_v2" "allow_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_inter_node_connections" {
  direction        = "ingress"
  ethertype        = "IPv4"
  remote_ip_prefix = var.network.subnet_cidr

  security_group_id = openstack_networking_secgroup_v2.k8s_secgroup.id
  //depends_on        = [openstack_networking_subnet_v2.k8s_subnet]
}

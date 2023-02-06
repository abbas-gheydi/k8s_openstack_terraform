resource "openstack_compute_servergroup_v2" "worker" {
  name     = "worker anti affinity"
  policies = ["anti-affinity"]
}


resource "openstack_compute_servergroup_v2" "master" {
  name     = "master anti affinity"
  policies = ["anti-affinity"]
}
variable "tenant_name" {
  type    = string
  default = "value"

}
variable "admin_pubick_key" {
  type    = string
  default = "admin"

}
variable "network_name" {
  type    = string
  default = "value"

}

variable "image_id" {
  type    = string
  default = "value"

}

variable "flavers" {
  type = object({
    master  = string
    worker  = string
    ansible = string
  })
  default = {
    ansible = "tiny-1"
    master  = "tiny-2"
    worker  = "tiny-3"
  }


}


variable "master_vm_count" {
  type    = number
  default = 3


}

variable "worker_vm_count" {
  type    = number
  default = 3


}


variable "firewall_trusted_ip" {
  type    = string
  default = "value"

}


variable "network" {
  type = object({
    name        = string
    subnet_cidr = string
  })
  default = {
    name        = "value"
    subnet_cidr = "value"
  }

}
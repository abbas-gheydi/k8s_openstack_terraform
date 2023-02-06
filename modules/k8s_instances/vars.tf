variable "master_vm_count" {
  type = number

}

variable "worker_vm_count" {
  type = number


}

variable "admin_pubick_key" {
  type = string

}

variable "flavers" {
  type = object({
    master  = string
    worker  = string
    ansible = string
  })
}


variable "image_id" {
  type = string

}

variable "network" {
  type = object({
    name        = string
    subnet_cidr = string
  })

}

variable "firewall_trusted_ip" {
  type = string

}
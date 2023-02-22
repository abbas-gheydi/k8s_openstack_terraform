variable "master_vm_count" {
  type = number

}

variable "worker_vm_count" {
  type = number


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

variable "ansible_key" {
  type = string  
}
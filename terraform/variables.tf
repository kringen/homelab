
variable "virtual_machines" {
    type = list(map(string))
    description = "List of key-value definitions for each virtual machine"
}

variable "ssh_public_key" {
    type = string
    description = "Public SSH key for connectiong to the VM"
}

variable "redhat_email" {
    type = string
}

variable "redhat_password" {
    type = string
}

variable "redhat_pool" {
    type = string
}
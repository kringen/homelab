data "template_file" "user_data" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm }
  template = file("${path.module}/cloud_init.cfg")

  vars = {
   hostname = each.value.name
   domain = each.value.domain
   ssh_public_key = var.ssh_public_key
   ssh_public_key2 = var.ssh_public_key2
  }
}
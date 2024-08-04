data "template_file" "ignition_template" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm }
  template = file("${path.module}/ignition_template.cfg")

  vars = {
   hostname = each.value.name
   domain = each.value.domain
   ssh_public_key = var.ssh_public_key
  }
}
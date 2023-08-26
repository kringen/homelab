data "template_file" "user_data" {
  for_each = { for index, vm in var.virtual_machines : 
              vm.name => vm }
  template = file("${path.module}/cloud_init.cfg")

  vars = {
   hostname = each.value.name
   domain = each.value.domain
   ssh_public_key = var.ssh_public_key
   redhat_email = var.redhat_email
   redhat_password = var.redhat_password
   redhat_pool = var.redhat_pool
  }
}
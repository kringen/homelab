terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kringlab"#var.tfc_organization

    workspaces {
      name = "kringlab-ubuntu"#var.tfc_workspace
    }
  }
}

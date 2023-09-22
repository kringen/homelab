terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kringlab"#var.tfc_organization

    workspaces {
      name = "kringlab-infrastructure"#var.tfc_workspace
    }
  }
}

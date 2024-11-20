base_image = "../ubuntu_qcow2/build/node/ubuntu-2404-amd64.qcow2"
cluster_id = "homelab"
local_user = "erik"
virtual_machines = [ 
    {
        "name"    = "${var.cluster_id}-control-plane"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:58"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "${var.cluster_id}-node01"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:59"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "${var.cluster_id}-node02"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:60"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },

]

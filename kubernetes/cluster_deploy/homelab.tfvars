base_image = "../../packer/k8s_node_ubuntu/build/node/ubuntu-2404-amd64.qcow2"
cluster_id = "homelab"
local_user = "erik"
virtual_machines = [ 
    {
        "name"    = "control-plane"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:58"
        "ip_address" = "10.0.0.108"
        "role"   = "control-plane"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "node01"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:59"
        "ip_address" = "10.0.0.109"
        "role"   = "worker_node"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "node02"
        "domain"  = "lab.kringen.local"
        "memory"  = "4096"
        "cpu"     = "4"
        "mac"     = "52:54:00:f2:1e:60"
        "ip_address" = "10.0.0.110"
        "role"   = "worker_node"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },

]

base_image = "../ubuntu_qcow2/build/node/ubuntu-2404-amd64.qcow2"
local_user = "erik"
virtual_machines = [ 
    {
        "name"    = "testlocalimage01"
        "domain"  = "lab.kringen.local"
        "memory"  = "2048"
        "cpu"     = "2"
        "mac"     = "52:54:00:f2:1e:54"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },

]

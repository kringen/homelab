virtual_machines = [ 
    {
        "name"    = "kringnode01"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:58"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    } ,
    {
        "name"    = "kringnode02"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:60"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "kringnode03"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:59"
        "bridge"   = "enp6s0"
        "host" = "kringlab01"
    },
    {
        "name"    = "kringnode04"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:56"
        "bridge"   = "enp38s0"
        "host" = "kringlab02"
    },
    {
        "name"    = "kringnode05"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:61"
        "bridge"   = "enp38s0"
        "host" = "kringlab02"
    },
    {
        "name"    = "kringnode06"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:57"
        "bridge"   = "enp38s0"
        "host" = "kringlab02"
    },
    {
        "name"    = "kringnode07"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:53"
        "bridge"   = "enp6s0"
        "host" = "kringlab03"
    } ,
    {
        "name"    = "kringnode08"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:55"
        "bridge"   = "enp6s0"
        "host" = "kringlab03"
    },
    {
        "name"    = "kringnode09"
        "domain"  = "lab.kringen.local"
        "memory"  = "8192"
        "cpu"     = "8"
        "mac"     = "52:54:00:f2:1e:54"
        "bridge"   = "enp6s0"
        "host" = "kringlab03"
    },
]
/*
virtual_machines:
- vm_name: kringnode04
  mac_address: 52:54:00:f2:1e:56
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.106
  vm_host: 10.0.0.20
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp38s0
- vm_name: kringnode06
  mac_address: 52:54:00:f2:1e:57
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.107
  vm_host: 10.0.0.20
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp38s0
- vm_name: kringnode01
  mac_address: 52:54:00:f2:1e:58
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.108
  vm_host: 10.0.0.10
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
- vm_name: kringnode03
  mac_address: 52:54:00:f2:1e:59
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.109
  vm_host: 10.0.0.10
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
- vm_name: kringnode02
  mac_address: 52:54:00:f2:1e:60
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.110
  vm_host: 10.0.0.10
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
- vm_name: kringnode05
  mac_address: 52:54:00:f2:1e:61
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.111
  vm_host: 10.0.0.20
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp38s0
- vm_name: kringnode09
  mac_address: 52:54:00:f2:1e:53
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.113
  vm_host: 10.0.0.30
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
- vm_name: kringnode08
  mac_address: 52:54:00:f2:1e:55
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.114
  vm_host: 10.0.0.30
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
- vm_name: kringnode07
  mac_address: 52:54:00:f2:1e:54
  vm_vcpus: 8
  vm_ram_mb: 8192
  ip_addr: 10.0.0.112
  vm_host: 10.0.0.30
  vm_base_image: rhel-8.5-x86_64-kvm.qcow2
  eth_device_name: enp6s0
  */

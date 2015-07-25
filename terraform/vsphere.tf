provider "vsphere" {
    user = "root"
    password = "vmware"
    vcenter_server = "192.168.16.132"
}

resource "vsphere_virtual_machine" "default" {
    name = "server01"
    datacenter = "MacBook"
    cluster = "ClusterBuster"
    vcpu = 2
    memory = 4096
    disk {
        datastore = "datastore1"
        template = "server_2012_r2"
    }
    
    network_interface {
        label = "Public Network"
    }
}

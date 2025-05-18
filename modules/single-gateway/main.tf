data "vsphere_datacenter" "datacenter" {
  name = var.datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.esxi_host
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "eth0_network" {
  name          = var.eth0_network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "eth1_network" {
  name          = var.eth1_network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_ovf_vm_template" "ovf" {
  name              = "Gateway-OVA"
  disk_provisioning = var.provision
  resource_pool_id  = data.vsphere_resource_pool.pool.id
  datastore_id      = data.vsphere_datastore.datastore.id
  host_system_id    = data.vsphere_host.host.id
  local_ovf_path    = var.local_ovf_path

}

resource "vsphere_virtual_machine" "vm" {
  name             = var.host_display_name != "" ? var.host_display_name : var.hostname
  datacenter_id    = data.vsphere_datacenter.datacenter.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_resource_pool.pool.id

  num_cpus             = var.num_cpus != 0 ? var.num_cpus : data.vsphere_ovf_vm_template.ovf.num_cpus
  num_cores_per_socket = var.num_cores_per_socket != 0 ? var.num_cores_per_socket : data.vsphere_ovf_vm_template.ovf.num_cores_per_socket
  memory            = var.memory != 0 ? var.memory : data.vsphere_ovf_vm_template.ovf.memory
  guest_id          = data.vsphere_ovf_vm_template.ovf.guest_id
  annotation        = data.vsphere_ovf_vm_template.ovf.annotation
  firmware          = data.vsphere_ovf_vm_template.ovf.firmware
  nested_hv_enabled = data.vsphere_ovf_vm_template.ovf.nested_hv_enabled
  scsi_type         = data.vsphere_ovf_vm_template.ovf.scsi_type
  custom_attributes = var.custom_attributes

  network_interface {
    network_id = data.vsphere_network.eth0_network.id
  }
  network_interface {
    network_id = data.vsphere_network.eth1_network.id
  }

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = data.vsphere_ovf_vm_template.ovf.local_ovf_path
    disk_provisioning         = var.provision
    ovf_network_map           = data.vsphere_ovf_vm_template.ovf.ovf_network_map
    enable_hidden_properties  = true // Dont Change!
  }

  vapp {
    properties = {
      "hostname"             = var.hostname,
      "run_ftw"              = "Yes",
      "eth0.ipaddress"       = var.eth0_ipaddress
      "eth0.subnetmask"      = var.eth0_subnet_mask
      "eth0.gatewayaddress"  = var.eth0_gateway_address

      "eth1.ipaddress"  = var.eth1_ipaddress
      "eth1.subnetmask" = var.eth1_subnet_mask

      "primary"             = var.primary_dns
      "proxy_port"          = var.proxy_port
      "proxy_address"       = var.proxy_address
      "ntp_primary"         = var.ntp_primary
      "ntp_primary_version" = var.ntp_primary_version
      "ssh_key" = var.ssh_key

      // GW configuration
      "CheckPoint.ftwSicKey"      = var.ftw_sic_key
      "CheckPoint.adminHash"      = var.admin_password
      "clish_commands"            = var.clish_commands
      "additional_configuration"  = var.additional_configuration
      // DO NOT CHANGE "user_data"!
      "user_data"                 = var.user_data
    }
  }

  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout  = 0

  lifecycle {
    ignore_changes = [
      num_cpus,
      num_cores_per_socket,
      memory,
      annotation,
      vapp[0].properties
    ]
  }
}

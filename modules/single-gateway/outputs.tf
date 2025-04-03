output "ip_external" {
  value = var.eth0_ipaddress
}

output "ip_internal" {
  value = var.eth1_ipaddress
}

output "hostname" {
  value = vsphere_virtual_machine.vm.name
}

output "managed_object_id" {
  value = vsphere_virtual_machine.vm.moid
}

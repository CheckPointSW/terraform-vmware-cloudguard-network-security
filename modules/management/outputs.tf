output "ip_external" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "hostname" {
  value = vsphere_virtual_machine.vm.name
}

output "managed_object_id" {
  value = vsphere_virtual_machine.vm.moid
}
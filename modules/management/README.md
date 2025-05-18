# Management Module

This Terraform module deploys a Check-Point CloudGuard Network Security Management Server solution into a vSphere
environment using an OVA template.

### Prerequisites

Check Point CloudGuard Network Security **"All deployment types" OVA**
from [CloudGuard Network for Private Cloud images](https://support.checkpoint.com/results/sk/sk158292) R81.20 or later.

## Usage

Follow best practices for using CGNS modules
on [main readme.md file](https://registry.terraform.io/modules/CheckPointSW/cloudguard-network-security/vmware/latest).

## Example Usage

```hcl
provider "vsphere" {}

module "management" {
  source = "CheckPointSW/cloudguard-network-security/vmware//modules/management"

  // VMware vCenter configuration
  datacenter_name   = "datacenter"
  resource_pool     = "my-pool"
  datastore         = "datastore-1"
  esxi_host         = "172.23.24.20"
  eth0_network_name = "external-network"
  local_ovf_path = "/home/file/jaguar_opt_main-777-991001696"
  hostname          = "Management-Server-example"

  // Management configuration
  eth0_ipaddress       = "172.23.24.10"
  eth0_subnet_mask     = 24
  eth0_gateway_address = "172.23.24.1"
  hostname             = "Management-example"
  admin_password       = "AdminPassword123!"
  mgmt_admin_passwd    = "guiPassword123!"
  maintenance_hash     = "maintenancePassword123!"
  ssh_key              = ""
}
```

## Argument Reference

- `datacenter_name`: (**Required**) The name of the vSphere datacenter.
- `resource_pool`: (**Required**) The resource pool in vCenter host name.
- `datastore`: (**Required**) The datastore name.
- `esxi_host`: (**Required**) The ESXi host name.
- `eth0_network_name`: (**Required**) The external network name.
- `local_ovf_path`: (**Required**) The local path to the OVF/OVA file.
- `admin_password`: (**Required**) Admin password.
- `hostname`: (**Required**) Management server hostname.
- `mgmt_gui_passwd`: (**Required**) Management GUI Client Password.
- `maintenance_hash`: (**Required**) Default maintenance password.
- `display_name`: (Optional) The display name of the Management server (from vCenter view). Default is the same as the `hostname`.
- `eth0_ipaddress`: (Optional) IP address for eth0. Leave blank for DHCP.
- `eth0_subnet_mask`: (Optional) Subnet mask for eth0. default is `24`. Leave blank for DHCP.
- `eth0_gateway_address`: (Optional) Gateway address for eth0. Leave blank for DHCP.
- `num_cpus`: (Optional) Number of CPUs for the Security Management.
- `num_cores_per_socket`: (Optional) Number of cores per socket for the Security Management.
- `memory`: (Optional) Memory size for the Security Management in MB.
- `provision` - (Optional) The disk provisioning type. If set, all the disks included in the OVF/OVA will have the same specified policy.
  One of `thin`, `thick`, `eagerZeroedThick`, or `sameAsSource`.
  * `thin`: Each disk is allocated and zeroed on demand as the space is used.
  * `thick`: Each disk is allocated at creation time and the space is zeroed on demand as the space is used.
  * `eagerZeroedThick`: Each disk is allocated and zeroed at creation time.
  * `sameAsSource`: Each disk will have the same disk type as the source. 
- `primary_dns`: (Optional) Primary DNS server.
- `proxy_port`: (Optional) Port of the proxy server.
- `proxy_address`: (Optional) Address of the proxy server.
- `ntp_primary`: (Optional) Primary NTP server.
- `ntp_primary_version`: (Optional) Version of the primary NTP server. Default is `4`.
- `mgmt_gui_clients_radio`: (Optional) Management GUI Clients Restriction. (any, range, network, this). `any` by default
- `mgmt_gui_clients_first_value`: (Optional) Depends "mgmt_gui_clients_radio" value:<br>If "any": leave blank<br>If "
  range": First IP in range for GUI clients.<br>If "network": Network address for GUI clients.<br>If "this": In case of
  a single IP address.
- `mgmt_gui_clients_second_value`: (Optional) Depends "mgmt_gui_clients_radio" value:<br>If "any": leave blank<br>If "
  range": Last IP in range for GUI clients.<br>If "network": Network mask for GUI clients.
- `high_availability_configuration`: (Optional) High availability configuration (Primary, Secondary). `Primary` by
  default.
- `ssh_key`: (Optional) SSH key.
- `clish_commands`: (Optional) Additional Clish commands in **base64**.
- `additional_configuration`: (Optional) Additional shell commands **in base64**.
- `custom_attributes`: (Optional) Map of custom attribute ids to attribute value strings to set for virtual machine.
  Please refer to
  the [vsphere_custom_attributes](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/custom_attribute#using-custom-attributes-in-a-supported-resource)
  resource for more information on setting custom attributes.
- `sic_for_secondary_mgmt`: (Optional) Secure Internal Communication key for secondary management.
- `download_info`: (Optional) Automatically download and install Software Blade Contracts, security updates, and other
  important data (very recommended). See sk175504. `Yes` by default
- `upload_info`: (Optional) Help Check Point improve the product by sending anonymous information. See sk175504. `Yes`
  by default.

## Outputs

- `ip_external`: External IP (eth0).
- `hostname`: The name of the Security Management Server.
- `managed_object_id`: The managed object ID of the Security Management Server.

```

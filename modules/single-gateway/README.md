# Check Point CloudGuard Single Gateway Module

This Terraform module deploys a Check-Point CloudGuard Network Security Single Gateway solution into a vSphere
environment using an OVA template.

### Prerequisites

Check Point CloudGuard Network Security **"Security Gateway only" OVA**
from [CloudGuard Network for Private Cloud images
](https://support.checkpoint.com/results/sk/sk158292) R81.20 or later.

## Usage

Follow best practices for using CGNS modules
on [main readme.md file](https://registry.terraform.io/modules/CheckPointSW/cloudguard-network-security/vmware/latest).

## Example Usage

```hcl
provider "vsphere" {}

module "single_gateway" {
  source = "CheckPointSW/cloudguard-network-security/vmware//modules/single-gateway"

  // VMware vCenter configuration
  datacenter_name   = "datacenter"
  resource_pool     = "my-pool"
  datastore         = "datastore-1"
  esxi_host         = "172.23.24.20"
  eth0_network_name = "external-network"
  eth1_network_name = "internal-network"
  local_ovf_path    = "/home/file/jaguar_opt_main-777-991001696-GW.ova"
  hostname          = "Security-Gateway-example"

  // Gateway configuration
  eth0_ipaddress       = "172.23.24.10"
  eth0_subnet_mask     = 24
  eth0_gateway_address = "172.23.24.1"
  eth1_ipaddress       = "10.10.10.20"
  eth1_subnet_mask     = 24
  admin_password       = "AdminPassword123!"
  ssh_key              = ""
  ftw_sic_key          = "123456789abcdABCD"
}
```

## Argument Reference

- `datacenter_name`: (**Required**) The name of the vSphere datacenter.
- `resource_pool`: (**Required**) The resource pool in vCenter host name.
- `datastore`: (**Required**) The datastore name.
- `esxi_host`: (**Required**) The ESXi host name.
- `eth0_network_name`: (**Required**) The external network name.
- `eth1_network_name`: (**Required**) The internal network name.
- `local_ovf_path`: (**Required**) The local path to the OVF/OVA file.
- `hostname`: (**Required**) The name of the Security Gateway.
- `admin_password`: (**Required**) Admin password.
- `ftw_sic_key`: (**Required**) Secure Internal Communication Key.
- `display_name`: (Optional) The display name of the Security Gateway (from vCenter view). Default is the same as the `hostname`.
- `eth0_ipaddress`: (Optional) IP address for eth0. Leave blank for DHCP.
- `eth0_subnet_mask`: (Optional) Subnet mask for eth0. Default is `24`. Leave blank for DHCP.
- `eth0_gateway_address`: (Optional) Gateway address for eth0. Leave blank for DHCP.
- `eth1_ipaddress`: (Optional) IP address for eth1. Leave blank for DHCP.
- `eth1_subnet_mask`: (Optional) Subnet mask for eth1. Default is `24`. Leave blank for DHCP.
- `num_cpus`: (Optional) Number of CPUs for the Security Gateway. Using OVF properties by default.
- `num_cores_per_socket`: (Optional) Number of cores per socket for the Security Gateway. Using OVF properties by
  default.
- `memory`: (Optional) Memory size for the Security Gateway in MB. Using OVF properties by default.
- `provision`: (Optional) Provision type (thin, flat, thick).
- `primary_dns`: (Optional) Primary DNS server.
- `ntp_primary`: (Optional) Primary NTP server.
- `ntp_primary_version`: (Optional) Version of the primary NTP server. Default is `4`.
- `ssh_key`: (Optional) SSH key.
- `clish_commands`: (Optional) Additional Clish commands **in base64**.
- `additional_configuration`: (Optional) Additional shell commands **in base64**.
- `custom_attributes`: (Optional) Map of custom attribute ids to attribute value strings to set for virtual machine.
  Please refer to
  the [vsphere_custom_attributes](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/resources/custom_attribute#using-custom-attributes-in-a-supported-resource)
  resource for more information on setting custom attributes.
- `download_info`: (Optional) Automatically download and install Software Blade Contracts, security updates, and other
  important data (very recommended). See sk175504. `Yes` by default
- `upload_info`: (Optional) Help Check Point improve the product by sending anonymous information. See sk175504. `Yes`
  by default.

## Outputs

- `ip_external`: External IP (eth0).
- `ip_internal`: Internal IP (eth1).
- `hostname`: The name of the Security Gateway.
- `managed_object_id`: The managed object ID of the Security Gateway.

```
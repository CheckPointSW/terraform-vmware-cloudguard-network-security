//****************** Basic Configuration Variables *********************//

variable "datacenter_name" {
  description = "Datacenter name"
  type        = string
}

variable "esxi_host" {
  description = "ESXi host name as it appears in vCenter"
  type        = string
}

variable "resource_pool" {
  description = "Resource pool name in vCenter"
  type        = string
}

variable "datastore" {
  description = "Datastore name"
  type        = string
}

//**************** Virtual Machine Instances Variables *****************//

variable "host_display_name" {
  description = "Display name of the Management server (from vCenter)"
  default     = ""
}

variable "hostname" {
  description = "Check Point Management server hostname"
  type        = string
  validation {
    condition     = length(var.hostname) >= 5
    error_message = "Hostname must be at least 5 characters long"
  }
}

variable "admin_password" {
  sensitive = true
  validation {
    condition     = length(var.admin_password) >= 6
    error_message = "Password must be at least 6 characters long"
  }
}

variable "local_ovf_path" {
  description = "Full path to OVF folder or OVA file"
}

variable "num_cpus" {
  type    = number
  default = 0
}

variable "num_cores_per_socket" {
  type    = number
  default = 0
}

variable "memory" {
  type    = number
  default = 0
}

variable "provision" {
  type    = string
  default = "thin"
}

variable "ssh_key" {
  default   = ""
  sensitive = true
}

//********************** Management Configurations ************************//

variable "sic_for_secondary_mgmt" {
  description = "Secure Internal Communication key"
  default     = ""
  validation {
    condition     = (var.high_availability_configuration != "Secondary" && var.sic_for_secondary_mgmt == "") || (var.high_availability_configuration == "Secondary" && 4 <= length(var.sic_for_secondary_mgmt))
    error_message = "sic_for_secondary_mgmt must be empty unless high_availability_configuration is 'Secondary', and must be at least 4 characters when set"
  }
}

variable "download_info" {
  description = "Automatically download and install Software Blade Contracts, security updates, and other important data (very recommended). See sk175504"
  default     = "Yes"
  validation {
    condition     = var.download_info == "Yes" || var.download_info == "No"
    error_message = "download_info must be either 'Yes' or 'No'"
  }
}

variable "upload_info" {
  description = "Help Check Point improve the product by sending anonymous information. See sk175504"
  default     = "Yes"
  validation {
    condition     = var.upload_info == "Yes" || var.upload_info == "No"
    error_message = "upload_info must be either 'Yes' or 'No'"
  }
}

variable "clish_commands" {
  description = "Additional Clish Commands, provided in base64"
  type        = string
  default     = ""
}

variable "additional_configuration" {
  description = "Advanced Configuration Settings provided in base64"
  type        = string
  default     = ""
}

variable "is_gateway_cluster_member" {
  description = "Enable/Disable ClusterXL. This option requires a reboot"
  type        = string
  default     = "No"
  validation {
    condition     = var.is_gateway_cluster_member == "Yes" || var.is_gateway_cluster_member == "No"
    error_message = "is_gateway_cluster_member must be either 'Yes' or 'No'"
  }
}

variable "custom_attributes" {
  type = map(string)
  default = {}
}

variable "mgmt_gui_password" {
  default     = ""
  sensitive   = true
  description = "Management GUI Client Password"
  validation {
    condition     = var.mgmt_gui_password == "" || length(var.mgmt_gui_password) >= 6
    error_message = "Minimal length is 6"
  }
}

variable "mgmt_gui_clients_radio" {
  default     = "any"
  description = "Management GUI Clients Restriction"
  validation {
    condition = (var.mgmt_gui_clients_radio == "any" ||
    var.mgmt_gui_clients_radio == "range" ||
    var.mgmt_gui_clients_radio == "network" ||
    var.mgmt_gui_clients_radio == "this")
    error_message = "options for mgmt_gui_clients_radio are {any,range,network,this}"
  }
}

variable "mgmt_gui_clients_first_value" {
  default = ""
}

variable "mgmt_gui_clients_second_value" {
  default = ""
}

variable "high_availability_configuration" {
  default     = "Primary"
  description = "Control install_mgmt_primary/install_mgmt_secondary config"
  validation {
    condition = (var.high_availability_configuration == "Primary" ||
    var.high_availability_configuration == "Secondary")
    error_message = "options for high_availability_configuration are 'Primary' or 'Secondary'"
  }
}

variable "maintenance_hash" {
  default     = ""
  sensitive   = true
  description = "Default maintenance password hash (to generate use grub2-mkpasswd-pbkdf2)"
}

//********************** Networking Variables **************************//

variable "eth0_network_name" {
  default     = ""
  description = "External Network name"
  type        = string
}

variable "eth0_ipaddress" {
  default  = ""
  nullable = true
}

variable "eth0_subnet_mask" {
  default  = 24
  nullable = true
}

variable "eth0_gateway_address" {
  default  = ""
  nullable = true
}

variable "primary_dns" {
  default  = ""
  nullable = true
}

variable "proxy_port" {
  default     = null
  description = "Optional parameter, port of the proxy server"
  nullable    = true
}

variable "proxy_address" {
  default     = null
  description = "Optional parameter, address of the proxy server. type: ipv4"
  type        = string
  nullable    = true
}

variable "ntp_primary" {
  default  = ""
  nullable = true
}

variable "ntp_primary_version" {
  default     = 4
  description = "Optional parameter, version of the primary NTP server"
  validation {
    condition     = var.ntp_primary_version >= 1 && var.ntp_primary_version <= 4
    error_message = "Invalid NTP version, allow range 1-4"
  }
}

variable "user_data" {
  description = "Cloud config, see sk179752. Do not Change"
  sensitive   = true
  default     = "I2Nsb3VkLWNvbmZpZw0KY29uZGl0aW9uczoNCiAgLSAhQ29uZGl0aW9uIFsgQWRkaXRpb25hbF9Db21tYW5kcyAgICAgICAgLCAhRXF1YWxzIFshTWV0YWRhdGEgImFkZGl0aW9uYWxfY29tbWFuZHMiLCAnJ10gXQ0KICAtICFDb25kaXRpb24gWyBBZGRpdGlvbmFsX0NsaXNoX0NvbW1hbmRzICAsICFFcXVhbHMgWyFNZXRhZGF0YSAiYWRkaXRpb25hbF9jbGlzaF9jb21tYW5kcyIsICcnXSBdDQogIC0gIUNvbmRpdGlvbiBbIFJ1bl9GVFcgICAgICAgICAgICAgICAgICAgICwgIUVxdWFscyBbIU1ldGFkYXRhICJydW5fZnR3IiwgIlllcyJdIF0NCiAgLSAhQ29uZGl0aW9uIFsgUHJpbWFyeSAgICAgICAgICAgICAgICAgICAgLCAhRXF1YWxzIFshTWV0YWRhdGEgImhpZ2hfYXZhaWxhYmlsaXR5X2NvbmZpZ3VyYXRpb24iLCAiUHJpbWFyeSJdIF0NCiAgLSAhQ29uZGl0aW9uIFsgU2Vjb25kYXJ5ICAgICAgICAgICAgICAgICAgLCAhRXF1YWxzIFshTWV0YWRhdGEgImhpZ2hfYXZhaWxhYmlsaXR5X2NvbmZpZ3VyYXRpb24iLCAiU2Vjb25kYXJ5Il0gXQ0KICAtICFDb25kaXRpb24gWyBHcmVhdGVyX1RoYW5fR2FpYVI4MTEwICAgICAsICFWZXJzaW9uR2UgWyAhVmVyc2lvbiAsICJSODEuMjAiXSBdDQogIC0gIUNvbmRpdGlvbiBbIFByb3h5X2FkZHJlc3MgICAgICAgICAgICAgICwgIUVxdWFscyBbIU1ldGFkYXRhICJwcm94eV9hZGRyZXNzIiwgJyddIF0NCiAgLSAhQ29uZGl0aW9uIFsgTWFpbnRlbmFuY2VfRW1wdHkgICAgICAgICAgLCAhRXF1YWxzIFshTWV0YWRhdGEgIm1haW50ZW5hbmNlX2hhc2giLCAnJ10gXQ0KICAtICFDb25kaXRpb24gWyBQcm94eV9wb3J0ICAgICAgICAgICAgICAgICAsICFFcXVhbHMgWyFNZXRhZGF0YSAicHJveHlfcG9ydCIsICcnXSBdDQogIC0gIUNvbmRpdGlvbiBbIFNldF9NYWludGVuYW5jZV9IYXNoICAgICAgICwgIUFuZCBbIEdyZWF0ZXJfVGhhbl9HYWlhUjgxMTAsICFOb3QgW01haW50ZW5hbmNlX0VtcHR5XSBdIF0NCiAgLSAhQ29uZGl0aW9uIFsgU2V0X1Byb3h5ICAgICAgICAgICAgICAgICAgLCAhQW5kIFsgIU5vdCBbUHJveHlfYWRkcmVzc10sICFOb3QgW1Byb3h5X3BvcnRdIF0gXQ0KICAtICFDb25kaXRpb24gWyBHVUlfUGFzc3dvcmRfRW1wdHkgICAgICAgICAsICFFcXVhbHMgWyFNZXRhZGF0YSAibWdtdF9hZG1pbl9wYXNzd2QiLCAnJ10gXQ0KDQp3cml0ZV9maWxlczoNCi0gZW5jb2Rpbmc6IGI2NA0KICBjb250ZW50OiAhTWV0YWRhdGEgImFkZGl0aW9uYWxfY29tbWFuZHMiDQogIHBhdGg6IC9vcHQvQ1BjZ2UvYm9vdC9hZGRpdGlvbmFsX2NvbW1hbmRzLnNoDQogIHBlcm1pc3Npb25zOiAnMDc1NScNCi0gZW5jb2Rpbmc6IGI2NA0KICBjb250ZW50OiAhTWV0YWRhdGEgImFkZGl0aW9uYWxfY2xpc2hfY29tbWFuZHMiDQogIHBhdGg6IC9vcHQvQ1BjZ2UvYm9vdC9hZGRpdGlvbmFsX2NsaXNoLnNoDQogIHBlcm1pc3Npb25zOiAnMDY0NCcNCi0gZW5jb2Rpbmc6IGI2NA0KICBjb250ZW50OiAnJw0KICBwYXRoOiAvZXRjLy5ibGlua19jbG91ZF9tb2RlDQogIHBlcm1pc3Npb25zOiAnMDY0NCcNCg0KcnVuY21kOg0KICAtICFJZiBbIEFkZGl0aW9uYWxfQ2xpc2hfQ29tbWFuZHMsICcnLCByZXRyeWFibGVfY2xpc2ggLXMgLWYgL29wdC9DUGNnZS9ib290L2FkZGl0aW9uYWxfY2xpc2guc2ggXQ0KICAtICFJZiBbIEFkZGl0aW9uYWxfQ29tbWFuZHMsICcnLCAvb3B0L0NQY2dlL2Jvb3QvYWRkaXRpb25hbF9jb21tYW5kcy5zaCBdDQogIC0gfA0KICAgIHNldCAtZQ0KICAgIGN2X3BhdGg9Ii9ldGMvY2xvdWQtdmVyc2lvbiINCiAgICBpZiB0ZXN0IC1mICRjdl9wYXRoOyB0aGVuDQogICAgICBlY2hvICJ0ZW1wbGF0ZV9uYW1lOiBtYW5hZ2VtZW50IiA+PiAkY3ZfcGF0aA0KICAgICAgZWNobyAidGVtcGxhdGVfdmVyc2lvbjogMjAyNTAzMTgiID4+ICRjdl9wYXRoDQogICAgICBlY2hvICJ0ZW1wbGF0ZV90eXBlOiB0ZXJyYWZvcm0iID4+ICRjdl9wYXRoDQogICAgZmkNCiAgICBjdl9qc29uX3BhdGg9Ii9ldGMvY2xvdWQtdmVyc2lvbi5qc29uIg0KICAgIGN2X2pzb25fcGF0aF90bXA9Ii9ldGMvY2xvdWQtdmVyc2lvbi10bXAuanNvbiINCiAgICBpZiB0ZXN0IC1mICRjdl9qc29uX3BhdGg7IHRoZW4NCiAgICAgICBjYXQgJGN2X2pzb25fcGF0aCB8IGpxICcudGVtcGxhdGVfbmFtZSA9ICJtYW5hZ2VtZW50IicgfCBqcSAnLnRlbXBsYXRlX3ZlcnNpb24gPSAiMjAyNTAzMTgiJyB8IGpxICcudGVtcGxhdGVfdHlwZSA9ICJ0ZXJyYWZvcm0iJyA+ICRjdl9qc29uX3BhdGhfdG1wDQogICAgICAgbXYgJGN2X2pzb25fcGF0aF90bXAgJGN2X2pzb25fcGF0aA0KICAgIGZpDQogIC0gdG91Y2ggL2V0Yy9maW5pc2hlZF91c2VyX2RhdGENCg0KY2xpc2g6DQogIC0gIUlmIFsgU2V0X1Byb3h5ICwgIUpvaW4gWyAiICIsIFsic2V0IHByb3h5IGFkZHJlc3MiICwgIU1ldGFkYXRhICJwcm94eV9hZGRyZXNzIiAsInBvcnQiLCAhTWV0YWRhdGEgInByb3h5X3BvcnQiICBdICBdICwgJyddDQoNCmJsaW5rX2NvbmZpZzoNCiAgaW5zdGFsbF9tZ210X3ByaW1hcnk6ICFJZiBbIFByaW1hcnksIHRydWUgLCBmYWxzZSBdDQogIGluc3RhbGxfbWdtdF9zZWNvbmRhcnk6ICFJZiBbIFNlY29uZGFyeSwgdHJ1ZSAsIGZhbHNlIF0NCiAgZnR3X3NpY19rZXk6ICFJZiBbIFNlY29uZGFyeSwgIU1ldGFkYXRhICJmdHdfa2V5IiAsIE51bGxdDQogIG1nbXRfYWRtaW5fcGFzc3dkIDogIUlmIFsgR1VJX1Bhc3N3b3JkX0VtcHR5LCBOdWxsICwgIU1ldGFkYXRhICJtZ210X2FkbWluX3Bhc3N3ZCIgXQ0KICBtYWludGVuYW5jZV9oYXNoOiAhSWYgWyBTZXRfTWFpbnRlbmFuY2VfSGFzaCwgIU1ldGFkYXRhICJtYWludGVuYW5jZV9oYXNoIiAsIE51bGwgXQ0KICBkb3dubG9hZF9pbmZvOiAhTWV0YWRhdGEgImRvd25sb2FkX2luZm8iDQogIHVwbG9hZF9pbmZvOiAhTWV0YWRhdGEgInVwbG9hZF9pbmZvIg0KICBtZ210X2FkbWluX3JhZGlvOiBnYWlhX2FkbWluDQogIGNvbmRpdGlvbiA6IFJ1bl9GVFc="
}
//****************** Basic Configuration Variables *********************//

variable "datacenter_name" {
  description = "Datacenter name"
  type        = string
}

variable "esxi_host" {
  description = "Host in vCenter host name"
  type        = string
}

variable "resource_pool" {
  description = "Resource Pool in vCenter host name"
  type        = string
}

variable "datastore" {
  description = "Datastore name"
  type        = string
}

//**************** Virtual Machine Instances Variables *****************//

variable "host_display_name" {
  description = "Display name of the gateway (from vCenter)"
}

variable "hostname" {
  description = "GateWay name"
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
  description = "Full path to OVA file"
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

variable "ssh_key" {
  sensitive = true
}

variable "provision" {
  type    = string
  default = "thin"
  validation {
    condition     = var.provision == "thin" || var.provision == "flat" || var.provision == "thick"
    error_message = "The provision value must be one of thin, flat, thick"
  }
}

//********************** Gateway Configurations ************************//

variable "ftw_sic_key" {
  description = "Secure Internal Communication key"
  validation {
    condition     = 4 <= length(var.ftw_sic_key)
    error_message = "SIC key must be at least 4 characters long"
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

variable "custom_attributes" {
  type = map(string)
  default = {}
}

//********************** Networking Variables **************************//

variable "eth0_network_name" {
  default     = ""
  description = "External Network name"
  type        = string
}

variable "eth1_network_name" {
  default     = ""
  description = "Internal Network name"
  type        = string
}

variable "eth0_ipaddress" {
  default  = ""
  nullable = true
}

variable "eth0_subnet_mask" {
  default = 24
}

variable "eth0_gateway_address" {
  default  = ""
  nullable = true
}

variable "eth1_ipaddress" {
  default  = ""
  nullable = true
}

variable "eth1_subnet_mask" {
  default = 24
}

variable "primary_dns" {
  default  = ""
  nullable = true
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

variable "proxy_address" {
  default     = null
  description = "Optional parameters, address of the proxy server"
  type        = string
  nullable    = true
}

variable "proxy_port" {
  default     = null
  description = "Optional parameters, port of the proxy server"
  nullable    = true
}

variable "user_data" {
  description = "Cloud config, see sk179752. Do not Change"
  sensitive   = true
  default     = "I2Nsb3VkLWNvbmZpZw0KY29uZGl0aW9uczoNCiAgLSAhQ29uZGl0aW9uIFsgQWRkaXRpb25hbF9Db21tYW5kcyAgICAgICwgIUVxdWFscyBbIU1ldGFkYXRhICJhZGRpdGlvbmFsX2NvbW1hbmRzIiwgJyddIF0NCiAgLSAhQ29uZGl0aW9uIFsgQWRkaXRpb25hbF9DbGlzaF9Db21tYW5kcywgIUVxdWFscyBbIU1ldGFkYXRhICJhZGRpdGlvbmFsX2NsaXNoX2NvbW1hbmRzIiwgJyddIF0NCiAgLSAhQ29uZGl0aW9uIFsgRlRXX0tleV9FbXB0eSAgICAgICAgICAgICwgIUVxdWFscyBbIU1ldGFkYXRhICJmdHdfa2V5IiwgJyddIF0NCiAgLSAhQ29uZGl0aW9uIFsgUnVuX0ZUVyAgICAgICAgICAgICAgICAgICwgIUFuZCBbICFFcXVhbHMgWyFNZXRhZGF0YSAicnVuX2Z0dyIsICJZZXMiXSAsIU5vdCBbRlRXX0tleV9FbXB0eV0gXSBdDQogIC0gIUNvbmRpdGlvbiBbIFByb3h5X2FkZHJlc3MgICAgICAgICAgICAsICFFcXVhbHMgWyFNZXRhZGF0YSAicHJveHlfYWRkcmVzcyIsICcnXSBdDQogIC0gIUNvbmRpdGlvbiBbIFByb3h5X3BvcnQgICAgICAgICAgICAgICAsICFFcXVhbHMgWyFNZXRhZGF0YSAicHJveHlfcG9ydCIsICcnXSBdDQogIC0gIUNvbmRpdGlvbiBbIFNldF9Qcm94eSAgICAgICAgICAgICAgICAsICFBbmQgWyAhTm90IFtQcm94eV9hZGRyZXNzXSwgIU5vdCBbUHJveHlfcG9ydF0gXSBdDQoNCg0Kd3JpdGVfZmlsZXM6DQogIC0gZW5jb2Rpbmc6IGI2NA0KICAgIGNvbnRlbnQ6ICFNZXRhZGF0YSAiYWRkaXRpb25hbF9jb21tYW5kcyINCiAgICBwYXRoOiAvb3B0L0NQY2dlL2Jvb3QvYWRkaXRpb25hbF9jb21tYW5kcy5zaA0KICAgIHBlcm1pc3Npb25zOiAnMDc1NScNCiAgLSBlbmNvZGluZzogYjY0DQogICAgY29udGVudDogIU1ldGFkYXRhICJhZGRpdGlvbmFsX2NsaXNoX2NvbW1hbmRzIg0KICAgIHBhdGg6IC9vcHQvQ1BjZ2UvYm9vdC9hZGRpdGlvbmFsX2NsaXNoLnNoDQogICAgcGVybWlzc2lvbnM6ICcwNjQ0Jw0KICAtIGVuY29kaW5nOiBiNjQNCiAgICBjb250ZW50OiAnJw0KICAgIHBhdGg6IC9ldGMvLmJsaW5rX2Nsb3VkX21vZGUNCiAgICBwZXJtaXNzaW9uczogJzA2NDQnDQoNCnJ1bmNtZDoNCiAgLSAhSWYgWyBBZGRpdGlvbmFsX0NsaXNoX0NvbW1hbmRzLCAnJywgcmV0cnlhYmxlX2NsaXNoIC1zIC1mIC9vcHQvQ1BjZ2UvYm9vdC9hZGRpdGlvbmFsX2NsaXNoLnNoIF0NCiAgLSAhSWYgWyBBZGRpdGlvbmFsX0NvbW1hbmRzLCAnJywgL29wdC9DUGNnZS9ib290L2FkZGl0aW9uYWxfY29tbWFuZHMuc2ggXQ0KICAtIHwNCiAgICBzZXQgLWUNCiAgICBjdl9wYXRoPSIvZXRjL2Nsb3VkLXZlcnNpb24iDQogICAgaWYgdGVzdCAtZiAkY3ZfcGF0aDsgdGhlbg0KICAgICAgZWNobyAidGVtcGxhdGVfbmFtZTogZ2F0ZXdheSIgPj4gJGN2X3BhdGgNCiAgICAgIGVjaG8gInRlbXBsYXRlX3ZlcnNpb246IDIwMjUwMzE4IiA+PiAkY3ZfcGF0aA0KICAgICAgZWNobyAidGVtcGxhdGVfdHlwZTogdGVycmFmb3JtIiA+PiAkY3ZfcGF0aA0KICAgIGZpDQogICAgY3ZfanNvbl9wYXRoPSIvZXRjL2Nsb3VkLXZlcnNpb24uanNvbiINCiAgICBjdl9qc29uX3BhdGhfdG1wPSIvZXRjL2Nsb3VkLXZlcnNpb24tdG1wLmpzb24iDQogICAgaWYgdGVzdCAtZiAkY3ZfanNvbl9wYXRoOyB0aGVuDQogICAgICAgY2F0ICRjdl9qc29uX3BhdGggfCBqcSAnLnRlbXBsYXRlX25hbWUgPSAiZ2F0ZXdheSInIHwganEgJy50ZW1wbGF0ZV92ZXJzaW9uID0gIjIwMjUwMzE4IicgfCBqcSAnLnRlbXBsYXRlX3R5cGUgPSAidGVycmFmb3JtIicgPiAkY3ZfanNvbl9wYXRoX3RtcA0KICAgICAgIG12ICRjdl9qc29uX3BhdGhfdG1wICRjdl9qc29uX3BhdGgNCiAgICBmaQ0KICAtIHRvdWNoIC9ldGMvZmluaXNoZWRfdXNlcl9kYXRhDQoNCmNsaXNoOg0KICAtICFJZiBbIFNldF9Qcm94eSAsICFKb2luIFsgIiAiLCBbInNldCBwcm94eSBhZGRyZXNzIiAsICFNZXRhZGF0YSAicHJveHlfYWRkcmVzcyIgLCJwb3J0IiwgIU1ldGFkYXRhICJwcm94eV9wb3J0IiAgXSBdICwgJyddDQoNCmJsaW5rX2NvbmZpZzoNCiAgZ2F0ZXdheV9jbHVzdGVyX21lbWJlcjogIU1ldGFkYXRhICJnYXRld2F5X2NsdXN0ZXJfbWVtYmVyIg0KICBkb3dubG9hZF9pbmZvOiAhTWV0YWRhdGEgImRvd25sb2FkX2luZm8iDQogIHVwbG9hZF9pbmZvOiAhTWV0YWRhdGEgInVwbG9hZF9pbmZvIg0KICBmdHdfc2ljX2tleTogIU1ldGFkYXRhICJmdHdfa2V5Ig0KICBjb25kaXRpb24gOiBSdW5fRlRX"
}
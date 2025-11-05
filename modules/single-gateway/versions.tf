terraform {
  required_version = ">=1.10.05"
  required_providers {
    vsphere = {
      source  = "vmware/vsphere"
      version = ">2.11.1"
    }
  }
}
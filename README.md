![GitHub Wachers](https://img.shields.io/github/watchers/CheckPointSW/terraform-vmware-cloudguard-network-security)
![GitHub Release](https://img.shields.io/github/v/release/CheckPointSW/terraform-vmware-cloudguard-network-security)
![GitHub Commits Since Last Commit](https://img.shields.io/github/commits-since/CheckPointSW/terraform-vmware-cloudguard-network-security/latest/master)
![GitHub Last Commit](https://img.shields.io/github/last-commit/CheckPointSW/terraform-vmware-cloudguard-network-security/master)
![GitHub Repo Size](https://img.shields.io/github/repo-size/CheckPointSW/terraform-vmware-cloudguard-network-security)
![GitHub Downloads](https://img.shields.io/github/downloads/CheckPointSW/terraform-vmware-cloudguard-network-security/total)


# Terraform Modules for CloudGuard Network Security (CGNS) — VMware (by Broadcom)

## Introduction
This repository provides a structured set of Terraform modules for deploying Check Point CloudGuard Network Security in VMware vCenter.<br>
These modules automate the creation of Security Gateways and Management servers.<br>
The repository contains:
* Terraform modules
* Community-supported content

### Prerequisites
* Terraform version v1.10.5 or later.
* VMware vCenter Server v7.0 or later.
* Check Point CloudGuard Network Security OVAs from [CloudGuard Network for Private Cloud images
  ](https://support.checkpoint.com/results/sk/sk158292) R81.20 or later.

## Repository Structure
`Submodules:` Contains modular, reusable, production-grade Terraform components, each with its own documentation.

<!-- `Examples:` Demonstrates how to use the modules. -->

**Submodules:**

* [`single_gateway`](https://registry.terraform.io/modules/CheckPointSW/cloudguard-network-security/vmware/latest/submodules/single_gateway) - Deploys CloudGuard Single Gateway solution into an existing network.
* [`management`](https://registry.terraform.io/modules/CheckPointSW/cloudguard-network-security/vmware/latest/submodules/management) - Deploys CloudGuard Management Server solution into an existing network.



***

# Best Practices for Using CloudGuard Modules

## Step 1: Use the Required Module
Add the required module in your Terraform configuration file to deploy resources. For example:

```hcl
provider "vsphere" {}

module "example_module" {
  source  = "CheckPointSW/cloudguard-network-security/vmware//modules/{module_name}"
  version = "{chosen_version}"
  # Add the required inputs
}
```
---
## Step 2: Open the Terminal

Ensure you have [Terraform](https://developer.hashicorp.com/terraform/install) installed and navigate to the directory
where your Terraform configuration file is located using the appropriate terminal:
- **Linux**: **Terminal**.
- **Windows**: **PowerShell** or **Command Prompt**.

---

## Step 3: Set Environment Variables
Set the required environment variables.


### Linux
```bash
export VSPHERE_USER="your_vsphere_username"
export VSPHERE_PASSWORD="your_vsphere_password"
export VSPHERE_SERVER="your_vsphere_server"
export VSPHERE_ALLOW_UNVERIFIED_SSL="false"  # Set to "true" if vCenter is using self-signed certificate
```
### PowerShell (Windows)
```PowerShell
$env:VSPHERE_USER="your_vsphere_username"
$env:VSPHERE_PASSWORD="your_vsphere_password"
$env:VSPHERE_SERVER"your_vsphere_server"
$env:VSPHERE_ALLOW_UNVERIFIED_SSL = "false"  # Set to "true" if vCenter is using self-signed certificate
```
### Command Prompt (Windows)
```cmd
set VSPHERE_SERVER=your_vsphere_server
set VSPHERE_USER=your_vsphere_username
set VSPHERE_PASSWORD=your_vsphere_password
set VSPHERE_ALLOW_UNVERIFIED_SSL=false  # Set to `true` if vCenter is using self-signed certificate
```
---

## Step 4: Deploy with Terraform
Use Terraform commands to deploy resources securely.

### Initialize Terraform
Prepare the working directory and download required provider plugins:
```shell
terraform init
```

### Plan Deployment
Preview the changes Terraform will make:
```shell
terraform plan
```
### Apply Deployment
Apply the planned changes and deploy the resources:
```shell
terraform apply
```
Notes:
1. Type `yes` when prompted to confirm the deployment.
2. The deployment takes a few minutes to complete (depending on the deployment size, can take ~30 minutes).

## Related Products and Solutions
* CloudGuard Network Security for [AWS](https://github.com/CheckPointSW/terraform-aws-cloudguard-network-security)
* CloudGuard Network Security for [Azure](https://github.com/CheckPointSW/terraform-azure-cloudguard-network-security)

## References
* For more information about Check Point CloudGuard for Public Cloud, see https://www.checkpoint.com/products/iaas-public-cloud-security/
* CloudGuard documentation is available at https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk132552&
* CloudGuard Network CheckMates community is available at https://community.checkpoint.com/t5/CloudGuard-IaaS/bd-p/cloudguard-iaas
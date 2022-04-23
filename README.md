# DevOps Prototype Infrastructure

This is a Terraform && Ansible IaC Application.


### Requirements

[Terraform](https://www.terraform.io/downloads)  
[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)  
[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


### AWS Configure

The AWS CLI stores this information in a profile (a collection of settings) named default in the credentials file.
[See here for more](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

Replace the example values with your own values:
```bash
$ aws configure
# AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
# AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
# Default region name [None]: us-west-2
# Default output format [None]: json
```


### Root Directory

Navigate to desired root directory

```bash
$ cd ./terraform/roots/<root>/
```


### Environments Setup

Copy `terraform.tfvars.template` to `terraform.tfvars`:

```bash
$ cp terraform.tfvars.example terraform.tfvars
```

Now open `terraform.tfvars` and enter environments values.


### Init

Prepare your working directory, install  providers plugins and set up GitLab-managed Terraform state.
[See here for Gitlab Personal Access Token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)

```bash
$ ./terraform-init.sh <"gitlab-username"> <"gitlab-access-token">
```


### Usage
Show changes required by the current configuration

```bash
$ terraform plan
```


### Apply

Create or update infrastructure

```bash
$ terraform apply
```


### More

Show this help output, or the help for a specified subcommand.

```bash
$ terraform -help
```

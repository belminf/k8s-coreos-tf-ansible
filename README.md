#

## Requirements
Ansible and Terraform installed.

## Cluster creation
### Create droplets with Terraform
```
cd terraform
terraform plan
terraform apply
cd ..
```

### Configure nodes with Ansible
Get latest CNI (`https://github.com/containernetworking/plugins/releases/`) and k8s release (`curl -sSL https://dl.k8s.io/release/stable.txt`) versions.
```
cd ansible
vim hosts
ansible-galaxy install vmware.coreos-bootstrap
ansible-playbook playbook.yml
```

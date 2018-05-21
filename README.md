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
```
cd ansible
vim hosts
ansible-galaxy install vmware.coreos-bootstrap
ansible-playbook playbook.yml
```

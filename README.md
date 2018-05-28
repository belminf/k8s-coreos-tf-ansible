# k8s-coreos-tf-ansible

## Requirements
Ansible and Terraform installed.

## Cluster creation
### Create droplets with Terraform
```
terraform plan
terraform apply
```

### Configure nodes with Ansible
Get latest CNI (`https://github.com/containernetworking/plugins/releases/`), flannel (`https://github.com/coreos/flannel/releases`) and k8s (`curl -sSL https://dl.k8s.io/release/stable.txt`) versions.
```
vim hosts
ansible-galaxy install vmware.coreos-bootstrap
ansible-playbook playbook.yml
```

## Sources
* https://kubernetes.io/docs/tasks/tools/install-kubeadm/
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

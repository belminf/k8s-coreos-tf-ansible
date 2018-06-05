# k8s-coreos-tf-ansible

## Requirements
Ansible and Terraform installed.

## Cluster creation
### Create GCP instances

Get your creds file:

1. Create project on Google Cloud
2. Enable Compute Engine API
3. Create service account JSON with Compute Admin role ("Credentials" page)
4. Save as `creds.json` (or whatever you setup as creds file in tfvars)

```
terraform init
terraform plan
terraform apply
```

### Configure nodes with Ansible
Get latest CNI (`https://github.com/containernetworking/plugins/releases/`), flannel (`https://github.com/coreos/flannel/releases`) and k8s (`curl -sSL https://dl.k8s.io/release/stable.txt`) versions.
```
cp hosts.example hosts
vim hosts
ansible-galaxy install vmware.coreos-bootstrap
ansible-playbook playbook.yml
```

## Use kubectl

```
KUBECONFIG=admin.conf kubectl get nodes
```

## Sources
* https://kubernetes.io/docs/tasks/tools/install-kubeadm/
* https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

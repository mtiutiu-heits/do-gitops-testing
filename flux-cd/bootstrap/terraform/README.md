# Bootstrapping Flux CD via Terraform and Github

This section contains information about how we can bootstrap **Flux CD** via **Terraform** using **Github** as a SCM provider and source of truth.

### Requirements:

1. [Terraform](https://www.terraform.io/downloads.html) must be installed first. 

E.g.: on MacOS it can be installed via Homebrew:
```bash
brew info terraform
brew install terraform
```
2. A [Github](https://github.com/) account. A [personal access token](https://github.com/settings/tokens) must be created as well with the `repo` permissions set (save it for later use).
3. A git client needs to be installed as well depending on the distro.
E.g.: on MacOS it can be installed via Homebrew:
```bash
brew info git
brew install git
```

### Installation steps

All of the following steps must be performed from a shell terminal after cloning this repository.

1. Clone this repository first on your local machine.
2. Change directory to `flux-cd/bootstrap/terraform`
3. Terraform initialization must be perfomed next by running: 
   
   `terraform init`

Sample output:
```
Initializing the backend...

Initializing provider plugins...
- Finding integrations/github versions matching ">= 4.5.2"...
- Finding hashicorp/kubernetes versions matching ">= 2.0.2"...
- Finding gavinbunney/kubectl versions matching ">= 1.10.0"...
...
```
4. Apply the changes (make sure to replace the `<>` placeholders with the right values): 
   
   `terraform apply -var="github_owner=<github_account_name>" -var="github_token=<personal_token_id>"`

Sample output:
```
tls_private_key.main: Creating...
kubernetes_namespace.flux_system: Creating...
github_repository.main: Creating...
tls_private_key.main: Creation complete after 2s [id=1d5ddec06b0f4daeea57d3a987029c1153ebcb21]
kubernetes_namespace.flux_system: Creation complete after 2s [id=flux-system]
kubectl_manifest.install["v1/serviceaccount/flux-system/source-controller"]: Creating...
kubectl_manifest.sync["kustomize.toolkit.fluxcd.io/v1beta1/kustomization/flux-system/flux-system"]: Creating...
kubectl_manifest.install["v1/serviceaccount/flux-system/helm-controller"]: Creating...
kubectl_manifest.install["networking.k8s.io/v1/networkpolicy/flux-system/allow-egress"]: Creating...
...
```
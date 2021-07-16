# GitOps via Flux CD

# Bootstrapping Flux CD via Terraform

This section contains information about how we can bootstrap **Flux CD** via **Terraform** using **Github** as a SCM provider and source of truth.

### Requirements:

1. We need a [Github](https://github.com/) account created first if none is available yet. 
2. A [personal access token](https://github.com/settings/tokens) must be created next with the `repo` permissions set (save it for later use).
3. A git client needs to be installed as well depending on the distro.
  
    E.g.: on MacOS it can be installed via Homebrew:
    ```bash
    brew info git
    brew install git
    ```

### Installation steps

All of the following steps must be performed from a shell terminal.

1. Clone this repository first on your local machine.
2. Change directory to `flux-cd/bootstrap/terraform`
   
    `cd flux-cd/bootstrap/terraform`
3. Terraform initialization must be perfomed next by running: 
   
    `terraform init`

    Sample output:
    ```
    Initializing the backend...

    Initializing provider plugins...
    - Finding integrations/github versions matching "4.12.2"...
    - Finding digitalocean/digitalocean versions matching "2.10.1"...
    - Finding hashicorp/kubernetes versions matching "2.3.2"...
    - Finding gavinbunney/kubectl versions matching "1.11.2"...
    - Finding fluxcd/flux versions matching "0.2.0"...
    ...
    ```
4. A Terraform `project.tfvars` variables file needs to be created next (this must not be commited in git as it may contain sensitive data - the `.gitignore` is already set to ignore this kind of file). There's a helper shell script created for this purpose `tfvars-helper.sh`
    From within `flux-cd/bootstrap/terraform`:
    ```bash
    ./tfvars-helper.sh
    ```
    Sample output:
    ```bash
    ./tfvars-helper.sh

    GitHub owner: foo
    GitHub personal token: foo087878_tFgHffoo
    GitHub repository name: test_foo
    ```
5. Create a `plan` first in order to inspect the infrastructure changes:

    `terraform plan -var-file="project.tfvars"`

6. If everything seems alright then `apply` the changes with: 
   
    `terraform apply -var-file="project.tfvars"`

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
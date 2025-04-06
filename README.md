# Satis

Create a Helm driven Satis deployment with NGiNX proxy.

![Satis](satis.webp)
 
## Prerequisites

The following files are necessary for a successful deployment.

An [`auth.json`](https://getcomposer.org/doc/articles/authentication-for-private-packages.md) and [`satis.json`](https://getcomposer.org/doc/articles/handling-private-packages.md) file with instance specific information in the `ansible/assets` subdirectory. (See links for reference)

### Ansible

An `main.yaml` file in the `ansible/defaults` subdirectory:

``` yaml
---
REPO: Path to the Satis repository
INSTALL: Path to the Satis installation
NAMESPACE: The Kubernetes namespace
...
```

#### Additional variables needed for Docker image creation

``` yaml
---
FPM: php-fpm version
COMPOSER: Composer version
NGiNX: `[repo]/[name]:[version]` of the NGiNX image
PHP: `[repo]/[name]:[version]` of the PHP image
SELF: Path to the local clone of the wordpress repository
...
```

An [`~/inventory.yaml`](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) file for Ansible to reference the hosts value. (See link for reference)

## Docker

The images can be built, tagged, and pushed to a container registry for easy access.

``` zsh
docker buildx build --file Dockerfile --tag [name] .

docker image tag [name]:latest [repo]/[name]:[version]

docker push [repo]/[name]:[version]
```

Or, using Ansible to automate the process:

``` zsh
ansible-playbook docker.yaml -i ~/inventory.yaml
```

## Helm

To install the deployment, navigate to the `helm` folder and run:

``` zsh
helm install [name] .
```

To update the deployment, edit the Helm charts as necessary and run:

``` zsh
helm upgrade [name] .
```

To delete the deployment, and remove all the created elements:

``` zsh
helm uninstall [name]
```

Finally, to automate the Satis instalation process, navigate to the `ansible` folder and run:

``` zsh
ansible-playbook playbook.yaml -i ~/inventory.yaml
```
# Satis

Create a Helm driven Satis deployment with NGiNX proxy.

![Satis](satis.webp)
 
## Prerequisites

The following files are necessary for a successful deployment.

An [`auth.json`](https://getcomposer.org/doc/articles/authentication-for-private-packages.md) and [`satis.json`](https://getcomposer.org/doc/articles/handling-private-packages.md) file with instance specific information in the `ansible/assets` subdirectory. (See links for reference)

### Ansible

An [`~/inventory.yaml`](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) file for Ansible to reference the hosts value. (See link for reference)

An `ansible/defaults/main.yaml` file containing variable declarations.

``` yaml
---
REPO: Path to the Satis repository
INSTALL: Path to the Satis installation
NAMESPACE: The Kubernetes namespace
...
```

## Docker

The images can be built, tagged, and pushed to a container registry for easy access.

``` zsh
docker buildx build --file Dockerfile --tag [name] .

docker image tag [name]:latest [repo]/[name]:[version]

docker push [repo]/[name]:[version]
```

Or, using Ansible / Docker Bake to automate the process:

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

## License

Code is distributed under [The Unlicense](https://bitbucket.org/bc-gov/desso-satis/src/main/LICENSE.md "Unlicense Yourself, Set Your Code Free") and is part of the Public Domain.

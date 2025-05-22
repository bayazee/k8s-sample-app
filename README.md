# k8s-sample-app

This repository demonstrates a complete Kubernetes deployment workflow using Helm, Traefik, and Cert-Manager. It includes a minimal nginx-based static website served over HTTPS with self-signed certificates and separated environments (dev and prod). 

## ⚠️ NOT Production Ready!!

This project is for educational purposes only and **not suitable for production use**. It intentionally uses simplified practices. Comments in the code highlight areas needing improvements for real-world usage.

### Examples of non-production practices:

- Use a secure external secret manager (e.g., Vault, AWS Secrets Manager) instead of passing secrets as environment variables.
- Implement a proper CI/CD pipeline with validation, tests, and approval stages.
- Deploy using GitOps tools such as ArgoCD or Flux for safe, automated updates.
- Integrate image and artifact scanning tools (e.g., Jfrog Xray, Trivy, Grype) into the pipeline.
- Add centralized logging and monitoring systems (e.g., ELK, Loki, Prometheus, Grafana).
- Enable end-to-end and at-rest encryption for all services and storage layers.
- Define and enforce network policies to restrict inter-pod communication.
- Set CPU and memory resource requests and limits for all workloads.
- Configure health checks, service availability monitoring, and alerting.
- Use deployment strategies like rolling updates, canary, or blue-green with rollback support.
- Define a Disaster Recovery (DR) strategy, including regular backups, multi-region redundancy, and recovery drills.

This list is a starting point. Each production environment has its own requirements that may demand additional safeguards.


## Features

- **Helm-based deployment** of all components
- **Traefik Ingress Controller** with (self-signed) TLS support
- **Cert-Manager** with self-signed certificate and secret sync between namespaces
- **Separate dev and prod environments** with isolated namespaces
- **Environment-specific secrets** injected as environment variables
- **Shell scripts** for bootstrap and cleanup
- **Docker-based build and push pipeline for website** with inline tests
- **Pre-commit hook configuration** with common validations

## Directory Structure

```plaintext
k8s-sample-app/
├── charts/                                  # Helm charts directory
│   ├── ssl/                                 # Chart for managing TLS certificate
│   │   ├── Chart.yaml                       # Helm chart metadata
│   │   ├── templates/
│   │   │   └── certificate.yaml             # cert-manager Certificate resource
│   │   └── values.yaml                      # Default values for the SSL chart
│   ├── traefik/                             # Chart for deploying Traefik ingress controller
│   │   └── values.yaml                      # Configuration for Traefik
│   └── website/                             # Chart for deploying the static website
│       ├── Chart.yaml                       # Helm chart metadata
│       ├── templates/
│       │   ├── deployment.yaml              # Website Deployment resource
│       │   ├── ingressroute.yaml            # Traefik IngressRoute for routing traffic
│       │   ├── middleware.yaml              # Traefik Middleware for different environments
│       │   ├── secret.yaml                  # Kubernetes Secret resource for app config
│       │   ├── _helpers.tpl                 # Helper template for generating labels
│       │   └── service.yaml                 # Service to expose the website internally
│       ├── values-dev.yaml                  # Dev environment overrides
│       └── values-prod.yaml                 # Prod environment overrides
├── website/                                 # Directory for the static website
│   ├── src/                                 # Static website files
│   │   └── index.html.tmpl                  # Main HTML page served by nginx
│   ├── ci-build.sh                          # CI build script for Docker image
│   ├── version.txt                          # Version file for Docker image
│   ├── Dockerfile                           # Dockerfile for building the website image
│   └── entrypoint.sh                        # Entrypoint script for the Docker container
├── scripts/                                 # Directory for shell scripts
│   ├── bootstrap.sh                         # Script to deploy all components (Traefik, cert-manager, website)
│   └── cleanup.sh                           # Script to uninstall all Helm releases and clean resources
├── .dockerignore                            # Files/directories to exclude from Docker build context
├── .pre-commit-config.yaml                  # Pre-commit hooks configuration
├── README.md                                # Project overview and documentation
└── LICENSE                                  # BSD 2-Clause license file
```

## Getting Started

```bash
./scripts/bootstrap.sh           # Deploy everything
./scripts/cleanup.sh             # Remove all resources
```

You can access the website using the domain defined in `website.values.yaml`, e.g., `https://website.bayazee.com`. In Minikube, use `minikube service traefik -n traefik` to get the port mapping.

## Website Details

The website is a static site served by nginx. The content is located in `website/src/index.html` and supports two environment variables:

- `ENVIRONMENT`: e.g., `dev`, `prod`
- `SECRET_MESSAGE`: injected secret

These are rendered into the HTML page dynamically.

## Docker Build & Test

The `build-website.sh` script builds the Docker image, runs two tests (HTTP and env validation), and pushes to Docker Hub if successful. The version is read from `version.txt`.

## Pre-commit Hooks

`.pre-commit-config.yaml` ensures basic hygiene:

- Trailing whitespace
- End-of-file fixer
- Large files check
- YAML/JSON/TOML validation
- Shebang script executability
- Merge conflict and private key detection

Run:

```bash
pre-commit install
```

## License

BSD 2-Clause License. See [LICENSE](./LICENSE).

## TODO

- [ ] Replace self-signed certs with valid TLS certs (e.g. Let's Encrypt)
- [ ] Use Terraform to manage infrastructure
- [ ] Create a proper CI/CD pipeline (e.g., GitHub Actions, GitLab CI)
- [ ] Container/image scanning & security hardening
- [ ] Add Linters and formatters for code quality
- [ ] Add monitoring and alerting (e.g., Prometheus, Grafana)
- [ ] Add centralized logging (e.g., ELK stack, Loki)
- [ ] Add network policies for security
- [ ] Use external secret management (e.g., HashiCorp Vault, AWS Secrets Manager)
- [ ] Implement RBAC (Role-Based Access Control)
- [ ] Use Secrets Store CSI Driver for Kubernetes
- [ ] Add CoreDNS and external DNS for dynamic DNS management


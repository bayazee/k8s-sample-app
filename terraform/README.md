# Terraform Infrastructure for k8s-sample-app

This folder contains the Terraform codebase used to provision and manage the infrastructure components of the `k8s-sample-app` project. The code defines modules and environment-specific deployments for local development and (eventually) cloud environments like AWS.
It supports both infrastructure and resources in AWS (or Minikube) and deploying applications and helm charts to Kubernetes clusters.

> ⚠️ **This setup is work-in-progress and not yet production-ready.**


## Todos

- [ ] Input variable validation across all modules
- [ ] Add automated linting with `tflint`
- [ ] Add documentation generation with `terraform-docs`
- [ ] Implement module testing and output validation
- [ ] Create encrypted backend config for remote state (for AWS)
- [ ] Store secrets in AWS Secrets Manager
- [ ] Harden production modules (timeouts, retries, dependencies)
- [ ] Create CI/CD pipeline for Terraform workflows

---

## Notes

- This setup currently targets **Minikube** in the `local` deployment.
- Helm is used for deploying `traefik`, `cert-manager`, and `reflector`.


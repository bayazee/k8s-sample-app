<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.37.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.37.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.traefik](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_helm_repo"></a> [helm\_repo](#input\_helm\_repo) | The Helm repository for Traefik | `string` | `"https://helm.traefik.io/traefik"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace in which to deploy Traefik | `string` | `"traefik"` | no |
| <a name="input_traefik_chart_name"></a> [traefik\_chart\_name](#input\_traefik\_chart\_name) | The name of the Traefik Helm chart | `string` | `"traefik"` | no |
| <a name="input_traefik_chart_version"></a> [traefik\_chart\_version](#input\_traefik\_chart\_version) | The version of the Traefik Helm chart to use | `string` | `"35.3.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_traefik"></a> [traefik](#output\_traefik) | n/a |
<!-- END_TF_DOCS -->
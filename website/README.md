# NGINX Static Website

This is a small NGINX-based static website, intended to be deployed in a Kubernetes environment using Traefik as the ingress controller and Helm as the deployment tool.

## Purpose

We aim to provide a simple HTML-based website that can be tested by developers and safely promoted to production.

## Environment Variables

The container supports the following environment variables:

- `ENVIRONMENT`: Optional. A string indicating the current environment (e.g., "dev", "prod").
- `SECRET_MESSAGE`: Optional. A secret message injected via Kubernetes secret, displayed on the website.

These variables are injected at runtime and rendered dynamically into the static HTML page.

## Build and Push

To build and publish the Docker image:

```bash
./build.sh
```

The script will:
- Read the version from `version.txt`
- Build the Docker image
- Run basic tests including HTTP checks and environment variable verification
- Push the image to Docker Hub if all tests pass

## Updating the Website

To update the website content:
1. Modify the HTML files under `html/`
2. Update version in `version.txt` file.
3. Run `./build.sh` to build and test
4. If successful, the new image will be pushed automatically

# Platform Engineering Lab

Practical Platform Engineering lab focused on building reusable,
automated and observable infrastructure.

## Goals

The project is used to develop and demonstrate practical skills in:

- Infrastructure as Code
- Terraform
- Cloudflare
- CI/CD
- Configuration Management
- Containers
- Kubernetes
- Monitoring
- Infrastructure Security
- troubleshooting

## Current Architecture

The current Terraform stack manages Cloudflare infrastructure consisting of:

- Cloudflare D1 database
- Cloudflare Worker
- Worker version and deployment
- D1 binding for the Worker
- Worker route
- DNS records
- HTTP health check

## Repository Structure

```text
projects/platform-lab/
├── terraform/
│   └── cloudflare/
│       ├── modules/
│       │   ├── database/
│       │   ├── dns-records/
│       │   └── worker/
│       ├── dev.tfvars.example
│       ├── index.js
│       ├── locals.tf
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```

## Planned Structure

The repository is planned to expand with:

- `ansible/` — server configuration and automation
- `application/` — application/API code
- `docs/` — architecture, operations and recovery documentation
- `kubernetes/` — Kubernetes manifests and deployment configuration
- `worker/` — local/edge worker components
- CI/CD workflows
- monitoring configuration

## Terraform

### Requirements
* Terraform
* Cloudflare account
* Cloudflare API token

### Configuration

Create a local variable file from the example:

```bash
cp dev.tfvars.example dev.tfvars
```
Configure the required values in dev.tfvars.

Cloudflare credentials should not be stored in Terraform configuration or
committed to Git.

The provider can authenticate using:
```bash
export CLOUDFLARE_API_TOKEN="..."
```

### Usage

Initialize Terraform:
```bash
terraform init
```
Format and validate the configuration:
```bash
terraform fmt -check -recursive
terraform validate
```
Review the execution plan:
```bash
terraform plan -var-file=dev.tfvars
```
Review the plan before applying any infrastructure changes.

## Terraform Modules

The Cloudflare stack currently uses reusable modules for:

### Worker

Manages:

* Cloudflare Worker
* Worker version
* Worker deployment
* Worker route
* D1 binding

### Database

Manages the Cloudflare D1 database and exposes its database ID as an output.

The root module passes this output to the Worker module:
```
module.database
      │
      │ database_id
      ▼
module.worker
```
### DNS Records

Manages Cloudflare DNS records.

## Health Check

Terraform uses an HTTP check to verify the Worker health endpoint.

The current health endpoint is:

`/health`

A failed check produces a warning without modifying the infrastructure.

## CI/CD

CI/CD is currently being introduced using GitHub Actions.

The initial pipeline will include:

* `terraform fmt -check`
* `terraform init`
* `terraform validate`
* `TFLint`

Terraform plan and controlled deployment workflows will be added separately.

## Security

The repository does not store:

* Terraform state
* ```.tfvars``` files containing environment-specific values
* API tokens
* saved Terraform plans

See ```.gitignore``` for excluded local files.

## Status

The project is under active development.

## Architecture Principles

- Reusable Terraform modules
- Explicit module input/output contracts
- Remote state for shared environments
- No secrets stored in Git
- Infrastructure changes reviewed through Terraform plans
- Minimal blast radius between environments

## Example change
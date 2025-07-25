# Advanced Application CI-CD Pipeline

----

An opinionated, end-to-end CI/CD stack that:

* builds and tests a sample Flask application inside Docker  
* pushes versioned images to Docker Hub  
* provisions AWS infrastructure with Terraform and ships the new image via an Application Load Balancer  
* runs integration tests before and after deployment, then tears the test stack down

> **Why?** To give teams a single, reproducible template they can fork and adapt for any container-based workload.

---

## Repository layout

| Path | What it contains |
| ---- | ---------------- |
| `.github/workflows/` | GitHub Actions pipelines (build, push, deploy, clean-up) |
| `app/` | A minimal Flask web service (HTML templates, static files, `app.py`) |
| `tests/` | pytest test-suite (unit + smoke) |
| `terraform/` | Modular IaC for VPC, ALB, Auto Scaling Group, RDS, S3 log bucket, etc. |
| `Dockerfile` | Multi-stage build for the Flask app |
| `DOCKER_VARS` | Two env vars: `VERSION` & `DOCKER_REPO` (read by the workflows) |
| `TODO` | Personal scratchpad / backlog items |

 [oai_citation:0‡GitHub](https://github.com/ThePinkPanther96/advanced-application-ci-cd-pipline)

---

## How the pipeline works

1. **Push / PR opened**  
   * `lint-and-test.yml` checks formatting (black + flake8) and runs `pytest`.
2. **Merge to `main`**  
   * `build-and-push.yml`  
     * reads `DOCKER_VARS`, builds `$DOCKER_REPO:$VERSION`, pushes to Docker Hub.  
   * `terraform-plan.yml` generates and uploads a plan artefact.
3. **Manual or auto-approve**  
   * `terraform-apply.yml` applies the plan, rolling the ASG to the new image.
4. **Post-deploy**  
   * `smoke-check.yml` hits `/healthz` through the public ALB; if it fails the job marks the deployment “failed”.
5. **Tag created (`v*`)**  
   * `release-notes.yml` drafts a GitHub Release, attaches the changelog and image digest.

> All workflows use reusable actions (`.github/actions/*`) to keep YAML DRY.

---

## Quick start

> You need Docker Desktop ≥ 24, Terraform ≥ 1.8, and an AWS account with programmatic access.

```bash
# 1. Fork & clone
git clone https://github.com/<you>/advanced-application-ci-cd-pipline.git
cd advanced-application-ci-cd-pipline

# 2. Configure secrets
gh secret set AWS_ACCESS_KEY_ID   -b "<access_key>"
gh secret set AWS_SECRET_ACCESS_KEY -b "<secret>"
gh secret set DOCKERHUB_USERNAME  -b "<docker_user>"
gh secret set DOCKERHUB_TOKEN     -b "<docker_pat>"

# 3. (optional) change image name / version
echo 'VERSION=1.0.1'   > DOCKER_VARS
echo 'DOCKER_REPO=myuser/myapp' >> DOCKER_VARS

# 4. Push a branch and open a PR – GitHub Actions will do the rest
git checkout -b feature/hello
git push -u origin feature/hello
```

---
## Local development

```sh
# build & run locally
docker compose up --build

# run tests
pytest -q
```

Visit http://localhost:5000

## **Terraform modules**

- **network** – VPC, subnets, NAT, IGW
    
- **compute** – Launch Template, Auto Scaling Group, ALB, Target Groups
    
- **data** – RDS PostgreSQL with encrypted storage
    
- **observability** – CloudWatch dashboards and alarms + Datadog forwarder (optional)
    

Each module is wired through a root main.tf that uses terragrunt.hcl to pass environment-specific variables.

---

## **Extending the template**

- Swap Flask for FastAPI or Express – only the Dockerfile and health-check path change.
    
- Replace Docker Hub with ECR – update the login step + DOCKER_REPO.
    
- Add staging/prod workspaces – duplicate the backend config in terraform-live/.
    

---
## **License**

MIT © 2025 Gal Rozman

```
### What to do next
* Add project badges (build status, Docker Hub pulls, license).  
* Fill in accurate AWS architecture diagrams or screenshots.  
* If you need sections trimmed or expanded, let me know!
```


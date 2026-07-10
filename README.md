# HMPPS Utility Container Images

These images are built in GitHub Actions and pushed to [GitHub Packages](https://github.com/orgs/ministryofjustice/packages?repo_name=hmpps-utility-container-images).

## Workflows

- `.github/workflows/docker-build-push.yml`: builds all utility images on push/workflow dispatch and on weekdays at 05:00 UTC. Images are pushed on `main`.
- `.github/workflows/clamav-daily.yml`: rebuilds `hmpps-clamav-freshclammed` twice daily (00:04 and 12:04 UTC) with a refreshed virus DB. Image is pushed on `main`.
- `.github/workflows/backup_repository.yml`: backs up this repository to SharePoint on schedule and by manual trigger.

## Security Scanning

Security scanning for utility container images is done with Snyk in `.github/workflows/docker-build-push.yml`.

- The workflow scans each built image in the matrix using `scan_type: image`.
- Scan results are uploaded to GitHub code scanning as SARIF.
- Slack notifications include scan context (including branch name) and a summary when findings are present.

## Images


| Image                       | Description                                                                                          |
|-----------------------------|------------------------------------------------------------------------------------------------------|
| `hmpps-devops-tools`        | contains various useful tools (az cli, aws cli, kubectl, helm), runs as non-root                     |
| `hmpps-jdk-debug`           | Eclipse Temurin 25 JDK for Kubernetes ephemeral container debugging                                  |
| `hmpps-mssql-tools`         | contains mssql-tools and az cli. For sqlserver db refresh jobs                                       |
| `hmpps-mysql-tools`         | contains mysql-client and aws cli. For mysql db refresh jobs, runs as non-root                       |
| `hmpps-postgres-tools`      | contains postgres-client. For postgres db tasks, runs as non-root                                    |
| `hmpps-wiremock`            | contains a CP friendly wiremock docker image. Runs as non-root and can add new responses as required |
| `hmpps-localstack`          | contains a CP localstack. Runs as non-root                                                           |
| `hmpps-clamav`              | ClamAV base image, see README in folder                                                              |
| `hmpps-clamav-freshclammed` | ClamAV image, twice daily updated virus DB, see README in folder                                     |
| `hmpps-python-deps`         | Python install with dependencies for running python scripts                                          |

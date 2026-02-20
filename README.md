# HMPPS Utility Container Images

These images are built in github actions see `.github/workflows/docker-build-push.yml` - and they are pushed to [GitHub Packages](https://github.com/orgs/ministryofjustice/packages?repo_name=hmpps-utility-container-images).

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

## Trivy Scan

We have a scheduled Trivy scan [GitHub Action](/.github/workflows/trivy_scan_latest.yml) which runs every week day.

Vulnerability failures can often be resolved by pushing an empty commit which will bump/refresh the container builds.

This also has the benefit of creating activity in the repository, as GitHub has the [policy of disabling scheduled workflows after 60 days of inactivity](https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow). See [Slack thread](https://mojdt.slack.com/archives/C69NWE339/p1676032009950009) discussing this.

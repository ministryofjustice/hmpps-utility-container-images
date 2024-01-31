# HMPPS Utility Container Images

These images are built in github actions see `.github/workflows/docker-build-push.yml` - and they are pushed to github packages.

| Dockerfile dir | Description | github package |
| --- | --- | --- |
| `hmpps-devops-tools` | contains various useful tools (az cli, aws cli, kubectl, helm), runs as non-root | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-devops-tools> |
| `hmpps-mssql-tools` | contains mssql-tools and az cli. For sqlserver db refresh jobs | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-mssql-tools> |
| `hmpps-mysql-tools` | contains mysql-client and aws cli. For mysql db refresh jobs, runs as non-root | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-mysql-tools>         |
| `hmpps-clamav` | ClamAV base image, see README in folder | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-clamav> |
| `hmpps-clamav-freshclammed` | ClamAV image, twice daily updated virus DB, see README in folder | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-clamav-freshclammed> |
| `hmpps-python-deps` | Python install with dependencies for running python scripts | <https://github.com/ministryofjustice/hmpps-utility-container-images/pkgs/container/hmpps-python-deps> |

## Trivy Scan

We have a scheduled Trivy scan [GitHub Action](/.github/workflows/trivy_scan_latest.yml) which runs every week day.

Vulnerability failures can often be resolved by pushing an empty commit which will bump/refresh the container builds.

This also has the benefit of creating activity in the repository, as GitHub has the [policy of disabling scheduled workflows after 60 days of inactivity](https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow). See [Slack thread](https://mojdt.slack.com/archives/C69NWE339/p1676032009950009) discussing this.

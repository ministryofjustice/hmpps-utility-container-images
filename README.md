# HMPPS Utility Container Images

These images are built in github actions see `.github/workflows/docker-build-push.yml` - and they are pushed to github packages.

| Dockerfile dir | Description | github package |
| --- | --- | --- |
| `hmpps-devops-tools` | contains various useful tools (az cli, aws cli, kubectl, helm), runs as non-root | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-devops-tools> |
| `hmpps-mssql-tools` | contains mssql-tools and az cli. For sqlserver db refresh jobs | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-mssql-tools> |
| `hmpps-clamav` | ClamAV base image, see README in folder | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-clamav> |
| `hmpps-clamav-freshclam-daily` | ClamAV image, daily updated virus DB, see README in folder | <https://github.com/ministryofjustice/hmpps-tools-images/pkgs/container/hmpps-clamav-freshclam-daily> |

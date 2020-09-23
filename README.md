# DPS Utility images

These images are built directly by quay.io (no circleci involvment), see webhooks on this gitbhub repo, and also quay.io repos (linked below)

| Dockerfile | Description | Quay.io |
| --- | --- | --- |
| `Dockerfile` | contains various useful tools (az cli, aws cli, kubectl, helm), runs as non-root | <https://quay.io/repository/hmpps/dps-tools> |
| `Dockerfile.mssql-tools` | contains mssql-tools and az cli. For sqlserver db refresh jobs | <https://quay.io/repository/hmpps/dps-mssql-tools> |

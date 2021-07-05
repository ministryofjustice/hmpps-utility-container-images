# hmpps-clamav

ClamAV docker image - see <https://www.clamav.net/>

This docker image is mostly borrowed from: <https://github.com/UKHomeOffice/docker-clamav>

## Usage and deployments

```sh
docker pull ghcr.io/ministryofjustice/hmpps-clamav-freshclam-daily:latest
```

The main Dockerfile in this folder is the a base image for `Dockerfile.freshclam-daily` - which is built and published everyday with an up-to-date virus DB. 

This daily built image can then be pulled (via k8s cronjob) by applications running CloudPlatforms cluster which require an up-to-date virus DB.

Note: This is an alternative solution to running a ClamAV mirror inside CloudPlatform's cluster - which no single team wanted to manage/run. The underlying issue was that with multiple teams all running clamav inside one kubernetes cluster we were hitting rate limiting issue with clamav's main download site that prevented freshclam from working, and so keeping the virus DB up-to-date.

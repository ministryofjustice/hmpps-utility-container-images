# hmpps-clamav

Repository which is used to build a tailored version of a ClamAV docker image.

This docker image is mostly borrowed from: <https://github.com/UKHomeOffice/docker-clamav> ...but with a few changes:

- Combined a RUN step to make the image smaller
- Specified a specific group ID for clamav, needed for the security context in the K8s volume mount
- Updated the clamav version to the current latest stable version


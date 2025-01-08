#checkov:skip=CKV_DOCKER_2:actions/runner does not provider a mechanism for checking the health of the service
FROM public.ecr.aws/ubuntu/ubuntu@sha256:4f5ca1c8b7abe2bd1162e629cafbd824c303b98954b1a168526aca6021f8affe

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="HMPPS DPS" \
      org.opencontainers.image.title="Actions Runner" \
      org.opencontainers.image.description="Actions Runner image for HMPPS DPS" \
      org.opencontainers.image.url="https://github.com/ministryofjustice/hmpps-utility-container-images"

ENV CONTAINER_USER="runner" \
    CONTAINER_UID="10000" \
    CONTAINER_GROUP="runner" \
    CONTAINER_GID="10000" \
    CONTAINER_HOME="/actions-runner" \
    DEBIAN_FRONTEND="noninteractive"

# Checked by renovate
ENV ACTIONS_RUNNER_VERSION="2.321.0" 

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

RUN <<EOF
groupadd \
  --gid ${CONTAINER_GID} \
  --system \
  ${CONTAINER_GROUP}

useradd \
  --uid ${CONTAINER_UID} \
  --gid ${CONTAINER_GROUP} \
  --create-home \
  ${CONTAINER_USER}

mkdir --parents ${CONTAINER_HOME}

chown --recursive ${CONTAINER_USER}:${CONTAINER_GROUP} ${CONTAINER_HOME}

apt-get update

apt-get install --yes --no-install-recommends \
  "apt-transport-https" \
  "ca-certificates" \
  "curl" \
  "git" \
  "jq" \
  "libicu-dev" \
  "lsb-release" \
  "gcc" \
  "libsqlite3-dev" \
  "python3" \
  "httpie"
 
apt-get clean

rm -rf /var/lib/apt/lists/*

curl --location "https://github.com/actions/runner/releases/download/v${ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz" \
  --output "actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz"

# Validate the checksum
ACTIONS_RUNNER_PKG_SHA=$(curl -s --location "https://github.com/actions/runner/releases/tag/v${ACTIONS_RUNNER_VERSION}" | grep -A10 "SHA-256 Checksums" | grep actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION} | awk -F'[<> ]' '{print $4}')
echo "Release ACTIONS_RUNNER_PKG_SHA   : ${ACTIONS_RUNNER_PKG_SHA}"
echo "Downloaded ACTIONS_RUNNER_PKG_SHA: $(sha256sum -b actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz) | cut -d\  -f1"

echo "${ACTIONS_RUNNER_PKG_SHA}"  "actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz" | /usr/bin/sha256sum --check

tar --extract --gzip --file="actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz" --directory="${CONTAINER_HOME}"

rm --force "actions-runner-linux-x64-${ACTIONS_RUNNER_VERSION}.tar.gz"
EOF

COPY --chown=nobody:nobody --chmod=0755 src/usr/local/bin/entrypoint.sh /usr/local/bin/entrypoint.sh

USER ${CONTAINER_UID}

WORKDIR ${CONTAINER_HOME}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

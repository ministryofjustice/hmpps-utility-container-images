FROM python:3.10-slim-bullseye

ENV \
  HELM_VERSION=3.11.3 \
  KUBECTL_VERSION=1.23.17

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -qy locales tzdata apt-utils apt-transport-https lsb-release gnupg software-properties-common build-essential vim jq zsh groff git curl wget zip unzip httpie \
    && locale-gen en_GB.UTF-8 \
    && ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /.cache/*

RUN pip install --upgrade pip \
    && pip install --no-cache-dir awscli aws-shell awscli-login boto3 botocore wheel urllib3

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install --no-install-recommends -qy azure-cli

RUN curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -L https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64

RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/postgresql.asc.gpg > /dev/null \
    && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && apt update && apt install --no-install-recommends -qy postgresql-client-15

RUN addgroup --gid 2000 --system appgroup && \
    adduser --uid 2000 --system appuser --gid 2000

USER 2000

CMD /bin/bash

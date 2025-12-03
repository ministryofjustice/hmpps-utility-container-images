FROM python:3-slim-bookworm

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -qy locales tzdata jq curl httpie lsb-release gnupg \
    && locale-gen en_GB.UTF-8 \
    && ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /.cache/*

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/postgresql.asc.gpg > /dev/null \
    && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && apt update && apt install --no-install-recommends -qy postgresql-client-18 postgresql-client-17 postgresql-client-16 postgresql-client-15

# Make version 16 the default for now.
ENV PATH="/usr/lib/postgresql/16/bin:$PATH"

RUN addgroup --gid 2000 --system appgroup && \
    adduser --uid 2000 --system appuser --gid 2000 --home /home/appuser

USER 2000

CMD /bin/bash

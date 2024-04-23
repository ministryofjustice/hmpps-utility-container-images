FROM ubuntu:20.04

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install --no-install-recommends -qy locales tzdata unzip curl ca-certificates mysql-client \
    && locale-gen en_GB.UTF-8 \
    && ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /.cache/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN addgroup --gid 2000 --system appgroup \
    && adduser --uid 2000 --system appuser --gid 2000

USER 2000

CMD /bin/bash

# SQL Server Command Line Tools
FROM ubuntu:24.04

LABEL maintainer="SQL Server Engineering Team"

# apt-get and system utilities
RUN apt-get update && apt-get install -y \
	curl apt-transport-https debconf-utils gnupg lsb-release \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

# install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 locales \
    && locale-gen en_GB.UTF-8 \
    && update-locale LANG=en_GB.UTF-8 \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="$PATH:/opt/mssql-tools18/bin"

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN groupadd --gid 2000 --system appgroup \
    && useradd --uid 2000 --system --gid 2000 --home-dir /home/appuser --create-home appuser

USER 2000

CMD ["/bin/bash"] 

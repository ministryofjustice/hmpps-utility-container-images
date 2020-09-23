# SQL Server Command Line Tools
FROM ubuntu:16.04

LABEL maintainer="SQL Server Engineering Team"

# apt-get and system utilities
RUN apt-get update && apt-get install -y \
	curl apt-transport-https debconf-utils \
    && rm -rf /var/lib/apt/lists/*

# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server drivers and tools
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools
ENV PATH "$PATH:/opt/mssql-tools/bin"
RUN /bin/bash -c "source ~/.bashrc"

RUN apt-get -y install locales
RUN locale-gen en_GB.UTF-8
RUN update-locale LANG=en_GB.UTF-8

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN addgroup --gid 2000 appgroup && \
    adduser --uid 2000 appuser --gid 2000

USER 2000

CMD /bin/bash 

FROM centos:latest

ENV CLAM_VERSION=0.104.1
ENV USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) Gecko/20100101 Chrome/96.0.4664.45"

COPY talos.pub /tmp/talos.pub

#Adding this for kubectl - used by the CronJob
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo

RUN yum update -y -q

# See https://docs.clamav.net/manual/Installing.html
RUN yum install -y epel-release && \
  yum install -y dnf-plugins-core && \
  yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
  yum config-manager --set-enabled PowerTools | \
  yum config-manager --set-enabled powertools | true

RUN yum install -y -q kubectl \
  libcurl-devel gcc-c++ openssl-devel wget make \
  python3 python3-pip valgrind \
  bzip2-devel check-devel json-c-devel libcurl-devel libxml2-devel \
  ncurses-devel openssl-devel pcre2-devel sendmail-devel zlib-devel

RUN wget -nv --user-agent="${USER_AGENT}" https://www.clamav.net/downloads/production/clamav-${CLAM_VERSION}.tar.gz && \
    wget -nv --user-agent="${USER_AGENT}" https://www.clamav.net/downloads/production/clamav-${CLAM_VERSION}.tar.gz.sig &&  \
    wget -nv https://cmake.org/files/v3.22/cmake-3.22.0.tar.gz && \
    gpg --import /tmp/talos.pub && \
    gpg --decrypt clamav-${CLAM_VERSION}.tar.gz.sig && \
    tar xzf clamav-${CLAM_VERSION}.tar.gz && \
    tar xzf cmake-3.22.0.tar.gz

RUN cd cmake-3.22.0 && \
    ./bootstrap && make && make install

RUN cd clamav-${CLAM_VERSION} && \
    mkdir build && cd build && \
    cmake .. && \
    cmake --build . && \
    ctest && \
    cmake --build . --target install

RUN rm -rf /clamav-${CLAM_VERSION} && \
    rm -rf /tmp/talos.pub && \
    yum remove -y -q wget make gcc-c++ openssl-devel kernel-headers

RUN yum clean all

# Add clamav user
RUN groupadd --gid 1000 clamav && \
    useradd -r -g clamav -u 1000 clamav -d /var/lib/clamav && \
    mkdir -p /var/lib/clamav && \
    mkdir /usr/local/share/clamav && \
    chown -R clamav:clamav /var/lib/clamav /usr/local/share/clamav

# Configure Clam AV...
RUN chown clamav:clamav -R /usr/local/etc/
COPY --chown=clamav:clamav ./*.conf /usr/local/etc/
COPY --chown=clamav:clamav eicar.com /
COPY --chown=clamav:clamav ./readyness.sh /

# permissions
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav

USER 1000

RUN freshclam --no-dns && \
    freshclam

VOLUME /var/lib/clamav

COPY --chown=clamav:clamav docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3310

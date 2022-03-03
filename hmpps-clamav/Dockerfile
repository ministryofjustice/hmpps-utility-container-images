FROM clamav/clamav:stable_base

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo

COPY --chown=clamav:clamav ./*.conf /etc/clamav

RUN groupadd --gid 1000 clamav && \
    useradd -r -g clamav -u 1000 clamav -d /var/lib/clamav && \
    mkdir -p /var/lib/clamav && \
    mkdir /usr/local/share/clamav && \
    chown -R clamav:clamav /var/lib/clamav /usr/local/share/clamav

COPY --chown=clamav:clamav eicar.com /
COPY --chown=clamav:clamav ./readyness.sh /

RUN freshclam

VOLUME /var/lib/clamav

COPY --chown=clamav:clamav docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3310

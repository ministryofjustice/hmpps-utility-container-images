FROM clamav/clamav:stable_base

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo

COPY --chown=clamav:clamav ./*.conf /etc/clamav
COPY --chown=clamav:clamav eicar.com /
COPY --chown=clamav:clamav ./readyness.sh /

RUN freshclam

VOLUME /var/lib/clamav

COPY --chown=clamav:clamav docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3310

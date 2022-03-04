FROM clamav/clamav:stable_base

COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo

COPY --chown=clamav:clamav ./*.conf /etc/clamav
COPY --chown=clamav:clamav eicar.com /
COPY --chown=clamav:clamav ./readyness.sh /

RUN freshclam

VOLUME /var/lib/clamav

COPY --chown=clamav:clamav docker-entrypoint.sh /

# We run as UID 1000 in kubernetes, this will allow us to start the process
RUN mkdir -p /var/run/clamav && \
  chown -R 1000:1000 /var/run/clamav && \
  chown -R 1000:1000 /var/lib/clamav
USER 1000

EXPOSE 3310

# Disable the entrypoint - I can't get it to stop running freshclam otherwise...
ENTRYPOINT []
CMD ["clamd"]

FROM clamav/clamav:stable_base

# Install kubectl - needed for our daily reload cronjob
ENV KUBECTL_VERSION=1.33
RUN apk update && \
    apk upgrade && \
    # Remediation: CVE-2023-38545 
    apk add --no-cache 'curl>8.4.0' && \
    curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/v$KUBECTL_VERSION/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

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
USER 1000:1000

EXPOSE 3310

# Disable the entrypoint - I can't get it to stop running freshclam otherwise...
ENTRYPOINT []
CMD ["clamd"]

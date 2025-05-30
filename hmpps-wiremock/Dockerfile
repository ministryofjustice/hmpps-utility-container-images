FROM wiremock/wiremock:nightly

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get install -y git jq &&  \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 2000 --system wiremock && adduser --uid 2000 --system wiremock --gid 2000

COPY --chown=wiremock:wiremock wiremock /home/wiremock
COPY --chmod=0755 entrypoint.sh /entrypoint.sh

USER 2000

ENTRYPOINT ["/entrypoint.sh"]
FROM wiremock/wiremock:latest
RUN addgroup --gid 2000 --system wiremock && adduser --uid 2000 --system wiremock --gid 2000

COPY --chown=wiremock:wiremock wiremock /home/wiremock

USER 2000
ENTRYPOINT ["/docker-entrypoint.sh", "--port=8090", "--global-response-templating", "--disable-gzip", "--verbose"]
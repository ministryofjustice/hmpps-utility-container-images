FROM alpine:3.16.2

RUN apk update && \
    apk upgrade && \
    apk add --no-cache aws-cli mysql-client bash tzdata && \
    cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo "Europe/London" > /etc/timezone && \
    apk del tzdata

RUN addgroup --gid 2000 --system appgroup && \
    adduser --uid 2000 --system appuser -g appgroup

USER 2000

CMD /bin/bash

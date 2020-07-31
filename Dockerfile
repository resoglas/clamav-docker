FROM alpine:latest

RUN set -eux; \
        apk add --no-cache clamav clamav-libunrar

RUN set -eux; \
        mkdir -p /run/clamav; \
        chown clamav:clamav /run/clamav

WORKDIR /etc/clamav

COPY clamd.conf freshclam.conf /etc/clamav/

RUN set -eux; \
        freshclam --quiet

EXPOSE 3310

VOLUME ["/var/lib/clamav", "/run/clamav"]

CMD ["clamd"]

USER clamav

COPY docker-clamav-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-clamav-entrypoint"]

ARG BASE_IMAGE=nats:2.11.0-preview.1-alpine3.19
FROM $BASE_IMAGE AS base

FROM scratch
ENV PATH="$PATH:/"

COPY --from=base /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf

EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

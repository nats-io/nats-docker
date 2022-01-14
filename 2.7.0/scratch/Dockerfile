FROM scratch
COPY --from=nats:2.7.0-alpine3.15 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

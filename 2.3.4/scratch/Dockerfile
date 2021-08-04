FROM scratch
COPY --from=nats:2.3.4-alpine3.14 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

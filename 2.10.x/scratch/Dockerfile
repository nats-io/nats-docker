FROM scratch
ENV PATH="$PATH:/"

COPY --from=nats:2.10.23-RC.8-alpine3.20 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf

EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

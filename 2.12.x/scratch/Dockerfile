FROM scratch
ENV PATH="$PATH:/"

COPY --from=nats:2.12.5-RC.2-alpine3.22 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf

EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

FROM scratch
COPY --from=nats:2.9.16-alpine3.17 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
ENV PATH="$PATH:/"
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

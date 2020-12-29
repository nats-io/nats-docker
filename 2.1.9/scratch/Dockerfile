FROM scratch
COPY --from=nats:2.1.9-alpine3.12 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
RUN adduser -g '' -h / -s /bin/sh -H -D nats
RUN chown root:nats /nats-server.conf /nats-server
RUN chmod 640 /nats-server.conf
RUN chmod 750 /nats-server
USER nats
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

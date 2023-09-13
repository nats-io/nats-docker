FROM scratch
ENV NATS_VERSION 2.9.22
COPY --from=nats:${NATS_VERSION}-alpine3.18 /usr/local/bin/nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
ENV PATH="$PATH:/"
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

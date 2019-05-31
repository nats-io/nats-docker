FROM scratch

COPY nats-server /nats-server
COPY nats-server.conf nats-server.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

# Run via the configuration file
ENTRYPOINT ["/nats-server"]
CMD ["-c", "nats-server.conf"]

FROM mcr.microsoft.com/windows/nanoserver:1803

# The NAT Server will look for this environment variable.
# When set, it prevents the use of the service API to detect
# if it is running in interactive mode or not, which is
# failing in the context of a Docker container.
# (https://github.com/nats-io/gnatsd/issues/543)
ENV NATS_DOCKERIZED=1

WORKDIR c:/nats-server
COPY nats-server.exe nats-server.exe
COPY nats-server.conf nats-server.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["nats-server"]
CMD ["-c", "nats-server.conf"]

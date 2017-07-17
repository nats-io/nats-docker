FROM microsoft/nanoserver

# The NAT Server will look for this environment variable.
# When set, it prevents the use of the service API to detect
# if it is running in interactive mode or not, which is
# failing in the context of a Docker container.
# (https://github.com/nats-io/gnatsd/issues/543)
ENV NATS_WIN_CONTAINER=1

WORKDIR c:/gnatsd
COPY gnatsd.exe gnatsd.exe
COPY gnatsd.conf gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]

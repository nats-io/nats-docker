FROM microsoft/nanoserver

ENV NATS_WIN_CONTAINER=1

WORKDIR c:/gnatsd
COPY gnatsd.exe gnatsd.exe
COPY gnatsd.conf gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]

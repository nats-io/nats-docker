# Build stage
FROM golang:1.12.9-windowsservercore-1809 as tmp
ENV SERVER_VERSION v2.1.0
ENV CGO_ENABLED 0
ENV GO111MODULE off
WORKDIR C:\\go\\src\\github.com\\nats-io\\nats-server
RUN $serverVersion = ('{0}' -f $env:SERVER_VERSION); \
	git clone --branch $serverVersion https://github.com/nats-io/nats-server.git .;
RUN $commit = git rev-parse --short HEAD; \
    $ldflags = ('-s -w -X github.com/nats-io/nats-server/server.gitCommit={0}' -f $commit); \
	go build -o C:\nats-server.exe -v -a -tags netgo -installsuffix netgo -ldflags "$ldflags";

# Final stage
FROM mcr.microsoft.com/windows/nanoserver:1809
ENV NATS_DOCKERIZED=1
COPY --from=tmp C:\\nats-server.exe C:\\nats-server.exe
COPY nats-server.conf C:\\nats-server.conf
EXPOSE 4222 8222 6222
ENTRYPOINT ["C:\\nats-server.exe"]
CMD ["--config", "nats-server.conf"]

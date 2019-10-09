# Build stage
FROM golang:1.12.9 as tmp
ENV SERVER_VERSION v2.1.0
ENV CGO_ENABLED 0
ENV GO111MODULE off
WORKDIR /go/src/github.com/nats-io/nats-server
RUN apt-get update; apt-get install -y git; \
    git clone --branch ${SERVER_VERSION} https://github.com/nats-io/nats-server.git .; \
	go build -v -o /nats-server -a -tags netgo -installsuffix netgo \
		-ldflags "-s -w -X github.com/nats-io/nats-server/server.gitCommit=$(git rev-parse --short HEAD)"

# Final stage
FROM scratch
COPY --from=tmp /nats-server /nats-server
COPY nats-server.conf /nats-server.conf
EXPOSE 4222 8222 6222
ENTRYPOINT ["/nats-server"]
CMD ["--config", "nats-server.conf"]

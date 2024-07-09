FROM alpine:3.20

ENV NATS_SERVER 2.10.18-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='fd8a9fd60a3663ef5e76f7125c0e0f587109ef14967818a614332d645aebec18' ;; \
		armhf) natsArch='arm6'; sha256='e938bde2ce5685c4074beef83b7eb15f49f1abd57313b0f30ad1b71b5344cb8b' ;; \
		armv7) natsArch='arm7'; sha256='441729695a92286ca38add036f1946ddb2026891451dfcf550ab8da55b5eb2d8' ;; \
		x86_64) natsArch='amd64'; sha256='d6a9ed30d03a200b9cd8a0fa6952cd963dc858f36bedeecf23e2dbd2d66a7786' ;; \
		x86) natsArch='386'; sha256='240c6f6847a90cc6568e50b2084b2181743ed0289615aeb6de4d57f94f967cf7' ;; \
		s390x) natsArch='s390x'; sha256='f70a090a1b04bacefe583f1b8c550137d5eaa3a1d5b44ee32be44c581d9a8b74' ;; \
		ppc64le) natsArch='ppc64le'; sha256='08e0a37df3ae6bafecae935d604bd09b5f8e802ea00e29f862e7f7d3724ed010' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates tzdata; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}";

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]

FROM alpine:3.19

ENV NATS_SERVER 2.10.8

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='3d74bba93d60a6a9836f4b54e942b8d4c2c9f33855659584cc7f76fdf8b1c4f7' ;; \
		armhf) natsArch='arm6'; sha256='63147f419cda88e2d6f508e7a93dcc35803ad07d3a25bd5bdfdf3830f22a096d' ;; \
		armv7) natsArch='arm7'; sha256='bc87934be36709f6f8928e5d65c7f11e8e2c5660826aa6c9af87b3a69cb6b8c3' ;; \
		x86_64) natsArch='amd64'; sha256='23f647b813f339f0c8c2ac545f75bebcb2821dce0f47eca50e475e44b5d663d9' ;; \
		x86) natsArch='386'; sha256='1ae8582969e34ff731bf065c724ad742ba2a1f566ad8de169b87f9e97b52f5ff' ;; \
		s390x) natsArch='s390x'; sha256='826735b8333787b27191cf201162398b530f417f2b80f224fefcfa9d21b480c2' ;; \
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

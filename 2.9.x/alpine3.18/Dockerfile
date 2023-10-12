FROM alpine:3.18

ENV NATS_SERVER 2.9.23

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='8c62d1c9f15651a22c4adaa9bfacffc3ade97f998bd5a5557074576ecf34bba2' ;; \
		armhf) natsArch='arm6'; sha256='93c252b9ac70f22d6fbbc0bc8bc8624287dd0955a6c3bb5057e576af9c7d355a' ;; \
		armv7) natsArch='arm7'; sha256='08e0c2a1b0d69135070464dce735038c99a882daadd1e3eaae050eacb61eac4c' ;; \
		x86_64) natsArch='amd64'; sha256='8a52b6b4a0337d3c58ee70888bf605cc732d792d9babe6bc9c984a1967aff15f' ;; \
		x86) natsArch='386'; sha256='102844ff97e19ab81728030e6a97e7cd7a228e63c07cc9132590d0193d3283d9' ;; \
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

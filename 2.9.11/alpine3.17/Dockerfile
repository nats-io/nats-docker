FROM alpine:3.17

ENV NATS_SERVER 2.9.11

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='0ff6e07f5cf211b643395132f63a69d69f0ed85ddcefd292b150574392e75edb' ;; \
		armhf) natsArch='arm6'; sha256='d2c58d51c5050582ec1888107a6eea041745b287548a37e27569437a4725c3ed' ;; \
		armv7) natsArch='arm7'; sha256='cef33d5b84473050e3dc0143117e336e90853e33d6329847612db88a1b8b139f' ;; \
		x86_64) natsArch='amd64'; sha256='7491944084cd0128c1ddf9a313095817a2c558b0911581c98e65b84779110856' ;; \
		x86) natsArch='386'; sha256='510eb4e4a32f1feba76232187767dd8ff0e021593f1cfbb6c5646343f3ca7a68' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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

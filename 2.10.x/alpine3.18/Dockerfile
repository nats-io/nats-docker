FROM alpine:3.18

ENV NATS_SERVER 2.10.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='13ab69dd6b35b4e253e97f469b61c4038fb6c1d0de89df6dfc93f75af1728ace' ;; \
		armhf) natsArch='arm6'; sha256='ad6da4b3289293624e1e60dd0c719d3f2c9cc768774b9f25e580c236915a906b' ;; \
		armv7) natsArch='arm7'; sha256='9a706550622ce44f06e6cc44621c01aa27aa9f5da4347d4295e65e986b5cb907' ;; \
		x86_64) natsArch='amd64'; sha256='f058d6195931f28cd14d2ac1b9b6a7ce1d760c66c76ccea72aa6b936f4b8d75c' ;; \
		x86) natsArch='386'; sha256='1c1e82380139758a69b5040631890914a9db5234517ef9d82b0173e37b8ca96a' ;; \
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

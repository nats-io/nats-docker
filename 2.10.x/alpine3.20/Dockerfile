FROM alpine:3.20

ENV NATS_SERVER 2.10.21

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='fe4124d7d8228a005d12a1b4a0f5fe12dfa33a6f99d56ae30a4ef3fe88e11b7e' ;; \
		armhf) natsArch='arm6'; sha256='96e8302636733a686e4864d0f59b9feed92f66d88ab12d69146d1db803e3bd31' ;; \
		armv7) natsArch='arm7'; sha256='a90b592ccab21ec063b03536298473d8d0399b30a467a8fa16602f30d6616f00' ;; \
		x86_64) natsArch='amd64'; sha256='004ddf97c3396511e3e6d356e9bc8760ad9c19e73443fd790a44fbf3ca63bb23' ;; \
		x86) natsArch='386'; sha256='053325da8f26554a0991882b9b4827a149bc6d0af2d806b7f618bb8f7581feac' ;; \
		s390x) natsArch='s390x'; sha256='b6a39675e8fa0e15431bf0a407adf13225f572027dd608e0e8f88ab3e09c8ebc' ;; \
		ppc64le) natsArch='ppc64le'; sha256='08177db78c3b70bd38471605e7acce19ad4f71324160b825e96f8dcd3f84fe2b' ;; \
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

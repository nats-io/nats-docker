FROM alpine:3.18

ENV NATS_SERVER 2.9.21

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6c2906b5a3b930e842c0a88772b5f484e962ac342f57852a45b1c5a7e10f2197' ;; \
		armhf) natsArch='arm6'; sha256='424576d72c1f3b5bd309254d0d0462e21b4aaf6b85defcf6663128294b15c16f' ;; \
		armv7) natsArch='arm7'; sha256='3ee6e4db568311c6832b1ec4d76933cc8ee1a783281ed89da5ebe6f602d1c521' ;; \
		x86_64) natsArch='amd64'; sha256='2bd2878a63efa5bc9b9c3f1d43fd953c7e14b22ba540f7dea19f7fb3a803215d' ;; \
		x86) natsArch='386'; sha256='6eef61e4a81fb03f47ef8bfe08eab6909846a3404db28b4260630385dc27910f' ;; \
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

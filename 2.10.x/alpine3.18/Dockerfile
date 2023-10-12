FROM alpine:3.18

ENV NATS_SERVER 2.10.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='924a92491f549be8e8d51d56fc0cd211e8326933b9e7c2bbd31af0fdc7f15240' ;; \
		armhf) natsArch='arm6'; sha256='dc8cfc756af14cda3c754ebfbe942616f7e3e65b8d846e7a34f5de2c55612a9d' ;; \
		armv7) natsArch='arm7'; sha256='f8e4cf88d50800650b0fed026e776d8ca7eace6b0cbc4762beca7d0f3590ba00' ;; \
		x86_64) natsArch='amd64'; sha256='a5587b04062a9cf117ec13aea5cb60cf4cd2e644be8c44628d85b5f4dfc19ab6' ;; \
		x86) natsArch='386'; sha256='e8a1a521aeeef68abf2b1bd3baf3f359a073c25cef4f87aa505a49c1b0920e90' ;; \
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

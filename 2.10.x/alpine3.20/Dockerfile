FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6a43ccbf75ba5547c3df131f47f45fa4ea53057071ac71e483920ca545cf926d' ;; \
		armhf) natsArch='arm6'; sha256='08afd09f9e65892b98b2ad6f74f8f8aa54910a316765ecfc7278e1b9a32d05c9' ;; \
		armv7) natsArch='arm7'; sha256='1ffcf4c834321f41fa9e4922aecfe8d9f0160443e6bba95d6d47f8d909ac5afe' ;; \
		x86_64) natsArch='amd64'; sha256='74095160d011affac650b43f5d98cf77dd408007804acd9a25a41c0162f9e1f5' ;; \
		x86) natsArch='386'; sha256='c353d84aa32b8387f1f8b450d2e212580575b0bc4a4ad6495d6a7dcac8afe141' ;; \
		s390x) natsArch='s390x'; sha256='a3500d8ef32aa03866c6014cf5eab5be4da3dc496a5f0e4ac80b1acca1c749ff' ;; \
		ppc64le) natsArch='ppc64le'; sha256='cc8d0ceaa883f430904380a58536d66a1624c7c0b57f443c12d1745b65002450' ;; \
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

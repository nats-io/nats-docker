FROM alpine:3.21

ENV NATS_SERVER 2.10.23-RC.11

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='56669aa862be7bd86f3053ee91ad8a47141cd517f808dbc5ca80cf8be8b8d1d6' ;; \
		armhf) natsArch='arm6'; sha256='e39c2620666d73a55bc57b62d5f97e22c514f869c538299453820da043744523' ;; \
		armv7) natsArch='arm7'; sha256='448cda40241d9c57827f072d3976e16ae15c55255bd6b09e6307b0552d2f4bd9' ;; \
		x86_64) natsArch='amd64'; sha256='08798ff58cc8b28cd18c08f9d9ecfeb76c6db726a016541bd7e9dce59150a07e' ;; \
		x86) natsArch='386'; sha256='dd4cad2d02b0cdc1fd0ffb82d057fbef354c28d468473b5e27f4aa1df8964397' ;; \
		s390x) natsArch='s390x'; sha256='b52e11aa1b2b5457272bee6752559bb3957b8b12e5a1734046dd4929ac22fe5d' ;; \
		ppc64le) natsArch='ppc64le'; sha256='c27059fa3d105fd790b64712a85af555934a23a083772adaf577061da5e7c6e0' ;; \
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

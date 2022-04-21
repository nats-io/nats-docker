FROM alpine:3.15

ENV NATS_SERVER 2.8.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='fa1226c8821c0487817ae3738112678d44f4b30a179acdf4ac6edb4b9e630a3d' ;; \
		armhf) natsArch='arm6'; sha256='9ff38ac7e93a993112a0a518935cfe2c41a3a19cab6c5920673e1f67bd550348' ;; \
		armv7) natsArch='arm7'; sha256='08acef43ae912954cf7b908487bc5d8a61985dab9ada2779b602c5d1176efd98' ;; \
		x86_64) natsArch='amd64'; sha256='7fa8300afa29afb0432abbb7455dc8517549b3cf1a32de8f4dc3617cca8e70a5' ;; \
		x86) natsArch='386'; sha256='e9c9a110aaf7113959659217bd976d7227e81cda6b74fe04f9649e7c57eb523e' ;; \
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

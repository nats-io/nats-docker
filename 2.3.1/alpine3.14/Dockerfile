FROM alpine:3.14

ENV NATS_SERVER 2.3.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4c6bc2eca0ab2e3d1dd2f7d44a2ff82443fbc5ffcd27c8df6506a961b6ced455' ;; \
		armhf) natsArch='arm6'; sha256='0c15c293d2e917f9f3450d759663033874ed90143643e18c696eb0cb9e3c9150' ;; \
		armv7) natsArch='arm7'; sha256='b9897a69b4448ee00c20251cf7593632770115b4878e1c885c3c4e266a12991c' ;; \
		x86_64) natsArch='amd64'; sha256='1478bb7bfacffa5d791edfd98557e68fb236b2b2b7f4c635c99d89e1ab7d8d71' ;; \
		x86) natsArch='386'; sha256='f8d4abf66b9a6900dea90f83a5e8d031e1878027c6a69f353a52ea6ea04fc427' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]

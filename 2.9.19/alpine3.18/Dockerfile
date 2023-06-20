FROM alpine:3.18

ENV NATS_SERVER 2.9.19

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='74d01dff16360fd4187f56005d1ca9783762e6693cc26ab015c73bddf1d02e48' ;; \
		armhf) natsArch='arm6'; sha256='b8160af8d6585a97c7c794c1dffaba0429757b51654986d4e64de6b1ca64d457' ;; \
		armv7) natsArch='arm7'; sha256='d2062448c98a907af83b2253c42b91a4cc98243f98e70f91a060d5eb94664dfe' ;; \
		x86_64) natsArch='amd64'; sha256='e3856357cba44652776ade8de6fd0d6198d484f7b2419e97fbec6a9edfe84c49' ;; \
		x86) natsArch='386'; sha256='a368c9f1456447093bc902fa2dffaaa1f282ed52a40cb2c4e015df80461b34a6' ;; \
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

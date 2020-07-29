FROM alpine:3.11

ENV NATS_SERVER 2.1.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64|arm64) natsArch='arm64'; sha256='a08d7ce0399df8701d3e3cd4c36744180c3a566cdb38efeccc12a364f0083705' ;; \
		armhf) natsArch='arm6'; sha256='987c23f758842fb09c0d4500f632c5302aedc61d218f03998444b94074aabddb' ;; \
		armv7) natsArch='arm7'; sha256='077fd1647aa25865ade5acc3d6ee5f542d2c62feb2fb41ec6d1dd83294bea05e' ;; \
		x86_64) natsArch='amd64'; sha256='23cce53fe7f628f203dbbeadf434c3480d094690aba6ff0b1d374b8f2f9ffd8c' ;; \
		x86) natsArch='386'; sha256='64e271690782af823930c95574db0f701d06a36ff42b9272c04841d4611bcd15' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.zip "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.zip"; \
	echo "${sha256} *nats-server.zip" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp unzip; \
	\
	unzip nats-server.zip "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server"; \
	rm nats-server.zip; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rmdir "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]

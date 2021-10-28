FROM alpine:3.14

ENV NATS_SERVER 2.6.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ee7f3782fa6b3be4a3be33bb144279993ac2624d2f26cfae1e53001ac56d3fc0' ;; \
		armhf) natsArch='arm6'; sha256='0adf63fc6c4084f53cbc50a6eedc43e6cec77e6d497eb79d7e429aa49189b40f' ;; \
		armv7) natsArch='arm7'; sha256='f36135c54a1409a4212a84fa40dfbc46049abd8f6e00c7da35d02bdbd5e63584' ;; \
		x86_64) natsArch='amd64'; sha256='91232ce15ae9ac408fea4ab1553bbc21a32f79d580e2ff28352c1de30bc8e089' ;; \
		x86) natsArch='386'; sha256='a4342321405eb62819ef287d4b2d48d3d628a611130960aa4ed3fb58b821d34d' ;; \
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

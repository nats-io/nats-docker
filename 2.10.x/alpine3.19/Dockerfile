FROM alpine:3.19

ENV NATS_SERVER 2.10.12

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='df353b32cc8813cc84b9a5fe131d702136bfbbcd3394d83cefe2dd59ecf9078c' ;; \
		armhf) natsArch='arm6'; sha256='665cd325e302b6536a846a0c4565f7c2fa2b83bed271ecda4255d508172920de' ;; \
		armv7) natsArch='arm7'; sha256='d5ff696d94dc0adc5a2d9863b42c139369b12c2b00e9768bc136d4f7dc50cbc2' ;; \
		x86_64) natsArch='amd64'; sha256='462584768f2e734d6be3cb5f24d817abef5191f3575091612e849e4718aac5dd' ;; \
		x86) natsArch='386'; sha256='bb991c52017b1b54568fb69420f7c6a127eb6a8f84c18dfe2e47a0ff29db42e4' ;; \
		s390x) natsArch='s390x'; sha256='84654e1d959e36c1549f47f36d7cb8f8a1395691ebf7c30ccc3ef8a0966f65fe' ;; \
		ppc64le) natsArch='ppc64le'; sha256='0c390ad5de7828c727428731c4ccc8f67ae7db7a4b68b7d3c07db0c8e595ecd6' ;; \
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

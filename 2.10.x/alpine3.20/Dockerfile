FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4a75aec8cdbb47d82b49fb3e75719e429266e1c867130834eacca5bf8a5e0ab1' ;; \
		armhf) natsArch='arm6'; sha256='59dd20b45a3778e052d7c335ecedbcb9636a04a1335d4e3825b41e8efa104c9c' ;; \
		armv7) natsArch='arm7'; sha256='31726b7d3c5a9bdc96f5b54a3666a5cb84a0904df557b11c59ae9448d2bc0e73' ;; \
		x86_64) natsArch='amd64'; sha256='988cdb2cc7b477fa35539fa0d9f5b3ad742db7b71411931785ef802bdd7361ed' ;; \
		x86) natsArch='386'; sha256='7f81549dc7b3cb2f186e5ebd9156f4488bffd1c912285e736397d9b6006ca022' ;; \
		s390x) natsArch='s390x'; sha256='6cdc7931c7f18a4bfbbab351e94fd52f4ceaf17ab3d4fa17222fa4e4fd40fac5' ;; \
		ppc64le) natsArch='ppc64le'; sha256='b422d56cec89d36a90eee3da5f4c8fef919ce67a169d637e5acb5040d6ee043f' ;; \
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

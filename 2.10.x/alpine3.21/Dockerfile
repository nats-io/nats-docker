FROM alpine:3.21

ENV NATS_SERVER 2.10.28-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='71ded08861d856b6150ba464e6fce98f484a745116d6826f487356de6c9d6b74' ;; \
		armhf) natsArch='arm6'; sha256='359cc36ad935ad0710712634354a5a106018121ffb685f05e5cf9b574a5aae2a' ;; \
		armv7) natsArch='arm7'; sha256='6f9d3bd2a1fbbf9ea4ed7814df394c42bc570675d4be0e4fa2242b81e3582b8c' ;; \
		x86_64) natsArch='amd64'; sha256='fa35baef07d44d1a7297eb38b39a855a43c9c4e424deed048c8e6ba3a3c741c1' ;; \
		x86) natsArch='386'; sha256='5b2921ca77dc34931d703872919011798e98fa1dda641bd22b72aeb176ddc768' ;; \
		s390x) natsArch='s390x'; sha256='71a35b5cc5f17789c2d5d85341bd6e97ca7596f4ac64489186b52fbdde252c9c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='e6fdeccf94c11b19fc4757eedeb052d429310ee9a552266bb8f7404045f16f9f' ;; \
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

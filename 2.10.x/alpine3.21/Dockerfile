FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='229b7f5a4c5ed7cc81809855c6fc6bb896929bc899744add2c6df3bfe5707b8f' ;; \
		armhf) natsArch='arm6'; sha256='9e905c1b47528045703b1d8f3b94c122656024c57aecbc9bece87a700e93fcbd' ;; \
		armv7) natsArch='arm7'; sha256='ad259013604681c18fbf12606fd1a226eafada745d9366e23f724ef8ad687817' ;; \
		x86_64) natsArch='amd64'; sha256='61bfa0b6286a5197a91873f69554e95ebea459bc637b0a2cdcb0130fa06a55b1' ;; \
		x86) natsArch='386'; sha256='8f7d7dbfa66936c32dc4f16764b957ac04fa2e1fc1302a23c8246dae9499a009' ;; \
		s390x) natsArch='s390x'; sha256='b968a58c28528eb7d73ed79525e4c857d0e267654064560e0c3d8b2ebcb71c26' ;; \
		ppc64le) natsArch='ppc64le'; sha256='136173c329b69d223f4c45169121d23faf9cc1a25a45a32bcd6051995d1cfff0' ;; \
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

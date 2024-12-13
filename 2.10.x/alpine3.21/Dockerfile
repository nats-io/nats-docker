FROM alpine:3.21

ENV NATS_SERVER 2.10.24-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='61d607bc9ca53ce53d5a0ccb7e3a9be6be9243c00cc167da1d2a2193c754bc25' ;; \
		armhf) natsArch='arm6'; sha256='994208bf4ea26991b5ebac0ded99beb923b2e89696ca3be488077976ed2cd632' ;; \
		armv7) natsArch='arm7'; sha256='968198883137420e8a77b5b07631c69fed1520ff3917346285c51087436bc7e0' ;; \
		x86_64) natsArch='amd64'; sha256='859fedaa0d456de72f69855f916723d0685da6fbe82440a0e548670db1e7fa47' ;; \
		x86) natsArch='386'; sha256='e303550b66766e5ae8be2b7695066ac3073086c1d76af652ed1e52477bc271a1' ;; \
		s390x) natsArch='s390x'; sha256='8d2b34dd28eadfcb3397b9f912cfe3f8f9c3956d59c9f63bb76400ef6d1e69a2' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d57ba3e53803a6c10b408ea02a77e582589d40fa9f49b4d7a4692ca17e84bad1' ;; \
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

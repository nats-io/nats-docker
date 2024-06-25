FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.8

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f589d710e927fc1cd8727d85249f6d0f1c82220192300b345f888da55f85bd5f' ;; \
		armhf) natsArch='arm6'; sha256='e119896f3bff75472c1dbbcda441a0146f97c508595a1ab2c5a4db2f5b20752d' ;; \
		armv7) natsArch='arm7'; sha256='b201797355ca38391405ed960b74d7fa2662e5a09878610ab82da9bc4d8ea8ec' ;; \
		x86_64) natsArch='amd64'; sha256='0b35ee31cb7c80bc7cac6bfe879c63cc5567d82a45d3c764960d0fbbb4c002d6' ;; \
		x86) natsArch='386'; sha256='dc42bee79cf3a3d1b8102be5bee97d48207cdebb7b57704ac5e102b75d3d3216' ;; \
		s390x) natsArch='s390x'; sha256='3743a80b8fce402816d44dade6574e64208b19052ecee069331c8869eeada0d1' ;; \
		ppc64le) natsArch='ppc64le'; sha256='4512c73ec21b53b7eba7d37718920a21725f9260d721cc1306ead84e4a79d5e4' ;; \
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

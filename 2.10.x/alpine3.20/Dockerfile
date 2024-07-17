FROM alpine:3.20

ENV NATS_SERVER 2.10.18

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='3f026443e902a21e787382ca10e1446bf02a8bb779224b1b7b33ea6483f76b02' ;; \
		armhf) natsArch='arm6'; sha256='69bc51de3e7c4f2585c68a51372f0b0e4fbc4048d9251606480dd0f416f28f87' ;; \
		armv7) natsArch='arm7'; sha256='80b7ba618d76f22b79bc192a4867c799e9c02fae10f8938d4514a3954f791174' ;; \
		x86_64) natsArch='amd64'; sha256='7760fe7347ba8e8daf4474811cf7fc301713aa8f3d4e0787d3e79a496dd537b2' ;; \
		x86) natsArch='386'; sha256='2e7cb64dd7f0de0256d74a2ea3792c63c3af28cddc66ce7101f1156e40941c56' ;; \
		s390x) natsArch='s390x'; sha256='c9534f9d4c6783780e71e61037890fcb4dda3917c875e904209aef3b7b5e74b0' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f6020a31d6fc3923b1782eb22f6f16e27f4e0c0a004ce8d014d7298c9a3a3082' ;; \
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

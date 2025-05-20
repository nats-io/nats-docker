FROM alpine:3.21

ENV NATS_SERVER 2.11.4-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f4cc348ead60e18f84c1fc81efdf107eb1a388b15bb5174cf8e7ef79be673a3c' ;; \
		armhf) natsArch='arm6'; sha256='57cfbde0673c1895d5e3d925f400a7f3ea87ded77dda1e0ae2c8ef45d04b0b3d' ;; \
		armv7) natsArch='arm7'; sha256='d7e6833d4aa1da9a4a2004e97b09fb61a1fefcf645e090cf0afa5c09346d16bf' ;; \
		x86_64) natsArch='amd64'; sha256='26f60e2ca5c23f75ced64c13522d250bffa4b8e2fb4e15c41d0aa16c407a041d' ;; \
		x86) natsArch='386'; sha256='dfdde422d37084123573ecceeb08f36f91b3103eba21cad0352d08e75c3cf9dc' ;; \
		s390x) natsArch='s390x'; sha256='dd07835f045043dbe80231b3386354c15b656b113b66a17152c8dfc8c3adabd2' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d937338ff7ab9779f1e9fe7bfcad4102c2c6f93e16387469f8cb2d6674de421e' ;; \
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

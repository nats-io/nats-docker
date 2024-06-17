FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='31569d0c21f2c73a2da6cfed569e268619b4f94a4f660478069b0f924a9d6712' ;; \
		armhf) natsArch='arm6'; sha256='e67459076950296a90ad9521e98fc86b49d51d4d5fdd701712e63b34f9f919e1' ;; \
		armv7) natsArch='arm7'; sha256='02706f183adba4f92b92cf9eb833e1ae8c6784b50c7aaa2808e21229dba04fc9' ;; \
		x86_64) natsArch='amd64'; sha256='df6c2e5d120431447bb9b00549a1d39e4be67c0330e432e1446d464fa6a7cf04' ;; \
		x86) natsArch='386'; sha256='a6f9450ed00f41fe1b6343414294f26418072e936d3d03431ade96cafb597b26' ;; \
		s390x) natsArch='s390x'; sha256='cc0e96a5dad3abf001c17c6292528dcf593da3bebcbdbec4559960e547f2bd4e' ;; \
		ppc64le) natsArch='ppc64le'; sha256='9bacde725e1d49be854554f782df2a901e3abe74b6527b1c030be77343786989' ;; \
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

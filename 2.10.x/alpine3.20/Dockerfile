FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.7

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='b27112197fe17c2e25bc489c98809850d4e09e3bdaba446a6fdd03f2589e7628' ;; \
		armhf) natsArch='arm6'; sha256='2f0009894485fc278ff9eb67da487ed67a948b08b7285cb305861f374090f47c' ;; \
		armv7) natsArch='arm7'; sha256='c3dbd9fc84d09f6b44215679fae468be416d6ce3ca2868089e1eb0ba2d59244e' ;; \
		x86_64) natsArch='amd64'; sha256='45a1c8c93b1359defa25526a01cbe1d16f659fee2ebaf4b2dec366861d7e5b30' ;; \
		x86) natsArch='386'; sha256='dd86c713a41a3309794aab30127db41e68f4710186eb0eb9a7918dc4919947ac' ;; \
		s390x) natsArch='s390x'; sha256='82a5f45b50e51b2cad7c1438c2c63ff3cdbd6fa88f688d104893f299104a0292' ;; \
		ppc64le) natsArch='ppc64le'; sha256='dfd31b1bb5188d0c1515442b7b3c6f3db107334c4bf44a0b9acdb30d9991a574' ;; \
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

FROM alpine:3.14

ENV NATS_SERVER 2.5.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='93f64cd14f04b4e7f6c3a2c10d09888be653406b7bc1a41f399ae44746388a5c' ;; \
		armhf) natsArch='arm6'; sha256='12f38f6881cdcf27c0faebb7ab6580b40253c36dc1531d499a29c4998a009494' ;; \
		armv7) natsArch='arm7'; sha256='fb3611b57a932f5c75310dee66597057ab65b442eb84d73b2c5fd9389eb6e518' ;; \
		x86_64) natsArch='amd64'; sha256='4d2f4abb15b45618ce772659c9f3eca60f25266dfc976f0354430ad67c8fd886' ;; \
		x86) natsArch='386'; sha256='776aecc77c33146d88e6b3cb1787097f9817122182f49f7243c0ea3fd62ad029' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-server.tar.gz; \
	rm nats-server.tar.gz; \
	mv "nats-server-v${NATS_SERVER}-linux-${natsArch}/nats-server" /usr/local/bin; \
	rm -rf "nats-server-v${NATS_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY nats-server.conf /etc/nats/nats-server.conf
COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]

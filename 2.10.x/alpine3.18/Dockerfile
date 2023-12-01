FROM alpine:3.18

ENV NATS_SERVER 2.10.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='89eade997286bf889cbbd40bd52e4952d318eb85d66387162d3539124c8ec5d5' ;; \
		armhf) natsArch='arm6'; sha256='2ebbdca481127ada62c5fc814ca4fea06ce18f0bdfc658769b589e1936b93566' ;; \
		armv7) natsArch='arm7'; sha256='c5c0532ff6c5c32674932fa97dee462020ce5e30401d7a089ce3a5c52c259d9d' ;; \
		x86_64) natsArch='amd64'; sha256='07a687d38ce737961adae346df8023ec5dc3a74e541931b911ec5e21491f6c2e' ;; \
		x86) natsArch='386'; sha256='921180ca022af2316db3dc0e00689a104771a5438ecf0f6db27e92f78a17509d' ;; \
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

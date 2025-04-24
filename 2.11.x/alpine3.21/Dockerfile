FROM alpine:3.21

ENV NATS_SERVER 2.11.2-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='432801ff1367defce7c3d88d3e82373537283b175bc1ea2e925082d66876a80c' ;; \
		armhf) natsArch='arm6'; sha256='cee98d7522e66243caa773176e0f0d3b602a5b52e9b8f375362ee3fdc6bdfce0' ;; \
		armv7) natsArch='arm7'; sha256='cc63788e5955d77da820f0e8ea0854bba810ca8e5cb4e1893c417590d876bddf' ;; \
		x86_64) natsArch='amd64'; sha256='d77d185386f63715d587ab3b1d2c527b6706ea1f3ad1edc8181262cf11c05156' ;; \
		x86) natsArch='386'; sha256='888004cc0f1df6e08c0de59a28316a55e0993ca2a4cac4171ede60aaea760054' ;; \
		s390x) natsArch='s390x'; sha256='b170c6d9ffeef32339e503b14f8eed4b4456047e7753c3f32511145a493d521c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='594e3176cfccc869c62876ccc944cb2c857d55513badd9a53f1a98410a3c6b22' ;; \
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

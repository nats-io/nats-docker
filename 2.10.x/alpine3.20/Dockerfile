FROM alpine:3.20

ENV NATS_SERVER 2.10.19

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='41e8d3fb78e255f1303d856e590a96a174edee02277edc72d58f882958f6449f' ;; \
		armhf) natsArch='arm6'; sha256='3c2fbdda83c9ff25e90abcca5b8c156b2c29fc9a8cab198626a80e9843ea5bdd' ;; \
		armv7) natsArch='arm7'; sha256='271b055c2bdb86dcc0de49001dce320f1fbf76949b5f3a8d730985d864144f88' ;; \
		x86_64) natsArch='amd64'; sha256='e64e6628795d26fc9c9b15b3894757cde3cefb85cb4a12c23001c997abd276dc' ;; \
		x86) natsArch='386'; sha256='bcf3d343e8877139c8af0713c380d073f6c0a773def1db75c81a8fdbe96a4e92' ;; \
		s390x) natsArch='s390x'; sha256='e7317aa5ea10047f6eb20e2dd6b5a305156b42928663a865be5f6f35bac56880' ;; \
		ppc64le) natsArch='ppc64le'; sha256='effd70f1322344c6a5261c5ccf6ccc6b67b77a6da23133d498628ed530ee8a62' ;; \
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

FROM alpine:3.20

ENV NATS_SERVER 2.10.22-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4e13647fefa7e80c51511ab4cf22fdc97ca9a84f15839e670518c6beda0b406c' ;; \
		armhf) natsArch='arm6'; sha256='473febcdd4bd92aea3f73f0f5d1006f6aed283344e2f89ee5e78ce4a66901119' ;; \
		armv7) natsArch='arm7'; sha256='67744b7f40639c1b9161a1b41caf04243fb10ec7b41aa1996562bc0b1d520767' ;; \
		x86_64) natsArch='amd64'; sha256='f65cea724e1d319af212b745e290e74bea97a5a4fa200d962c4e4ba331b2a9ee' ;; \
		x86) natsArch='386'; sha256='e528fa15724415eb181aff0f7100ff397e598f3ed70f0506c9b295597c451d50' ;; \
		s390x) natsArch='s390x'; sha256='39d289211271dbfbd3e8276a2435ea66452c9137e4a0d95a44c54e0627519694' ;; \
		ppc64le) natsArch='ppc64le'; sha256='6052b658d5e08041d587405f47e6a79a3f09fb906a61ec998fd2fcf7778aec85' ;; \
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

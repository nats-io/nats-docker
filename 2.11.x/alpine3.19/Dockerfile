FROM alpine:3.19

ENV NATS_SERVER 2.11.0-preview.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='5a4021968b52cf1b1dc3addb614ff77e6a27e02789030a2575df3d4f445f2c5b' ;; \
		armhf) natsArch='arm6'; sha256='9af849a9601beb27d1dedc1d7b252dad7caa491f296844a781e432a00c4b9c6c' ;; \
		armv7) natsArch='arm7'; sha256='a77bd6def83e9e135ffc5dd26e59e67f85911be87fe80996e2095f8a04b0d97b' ;; \
		x86_64) natsArch='amd64'; sha256='a85ad549eda466e8119678cc5e1ae202124020dae693fbd90f8ed833dc50ce58' ;; \
		x86) natsArch='386'; sha256='8541e9bb60bd4595795f9a37eb6322de0a9ba6a8ca00ea77712f6eb87d3959e0' ;; \
		s390x) natsArch='s390x'; sha256='a113815fe4385bbf8e242ef54738ffcf55cdfb7ad96c31c8d7589bc53d0d9040' ;; \
		ppc64le) natsArch='ppc64le'; sha256='8bc30847f303425508d07ff24a2347b05df6e6fe4192c09cffe7fcfbeaefb7bc' ;; \
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

RUN apk add --no-cache libcap \
  && setcap cap_net_bind_service=+ep /usr/local/bin/nats-server \
  && apk del libcap

EXPOSE 4222 8222 6222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-server", "--config", "/etc/nats/nats-server.conf"]

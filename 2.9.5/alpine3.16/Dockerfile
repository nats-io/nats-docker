FROM alpine:3.16

ENV NATS_SERVER 2.9.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='490821b628421ce516ca8ed4d31e25e88577aa530a1eac53df51366ebcf6149b' ;; \
		armhf) natsArch='arm6'; sha256='d8b1e79ad136dc381b86192110531b2bae716408baf57d8ade3000fbbd957810' ;; \
		armv7) natsArch='arm7'; sha256='e9cd21a0f203448b6816fbeaa73a63028bfa48bede37549c4dcc1c9311755e5b' ;; \
		x86_64) natsArch='amd64'; sha256='3e488e579c091da8fd628db69795cc4cdc8b376c516561e4a7c5fa5ff3874ec7' ;; \
		x86) natsArch='386'; sha256='8606cafb62a5957abf720baeb1217b1adcd336d75a263d8b61528c03e34e04b9' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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

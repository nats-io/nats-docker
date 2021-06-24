FROM alpine:3.13

ENV NATS_SERVER 2.3.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='139521edba99389436c95b12b93aa4e7fbc0b2d07ac8584902cfc4d417773d3c' ;; \
		armhf) natsArch='arm6'; sha256='ebc1907729fa322c1191ce605e55c54f063bacf5f811802e8a32076210131975' ;; \
		armv7) natsArch='arm7'; sha256='30476c49ca5f1404b7bc3536ad325da9d8c7eb6f733c1b992fc20bf288e15eeb' ;; \
		x86_64) natsArch='amd64'; sha256='3a6097371169d750d73b643f2d4644b99e575e966a99e8458426bbfccb8fda7b' ;; \
		x86) natsArch='386'; sha256='37715ed91c4a3698fde4ba69f2bf8fd3cd1346347bbab97f3af176cdbcb47b05' ;; \
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

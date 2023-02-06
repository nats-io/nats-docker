FROM alpine:3.17

ENV NATS_SERVER 2.9.14

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='6032bc7b2621256e2d9f62f2a987eef490f071bde04dca09786d0270130f9cfd' ;; \
		armhf) natsArch='arm6'; sha256='afbee67b87868dc29cf6c382f87813de264572472ac7513a66db6e99fd2a24ac' ;; \
		armv7) natsArch='arm7'; sha256='e7e5c019e6cc3d6ef72da80defd5a4f95690b8d108ebb2cfd74fc9c47ac00706' ;; \
		x86_64) natsArch='amd64'; sha256='18ac6d0a3956a3d293b85c33822159188b9e75b7597241e2c821e9ded7456601' ;; \
		x86) natsArch='386'; sha256='637363cf3ca923c8762ecd083cf83c15cad505ed011ddbbaea857d982a1dadcf' ;; \
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

FROM alpine:3.21

ENV NATS_SERVER 2.10.29-RC.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='850babec8d23d5edf678fb5e3d7fa441eb885f5bdf14b6811c25770280543fb9' ;; \
		armhf) natsArch='arm6'; sha256='9dca25c4dc78446b24568af7dba2b9f79599608c22755aa9c0b4e6232f81f6a7' ;; \
		armv7) natsArch='arm7'; sha256='a8bb844bb68ee2d6e34ccd186e2dcd98ef3041d0ee3456066bf094d786b0d115' ;; \
		x86_64) natsArch='amd64'; sha256='ea984cc71f3a015cd3b65e4fe093f6088a91ad5c60456fe9a2a844d4e9ae5c08' ;; \
		x86) natsArch='386'; sha256='f6454d51ba1adb0c1a70e3d375228d059bb8ba2b24b8771b1ca26a36dbc53229' ;; \
		s390x) natsArch='s390x'; sha256='323b3f0595cbb1ff940a32e2b849d9a7063cdb49bfccedd18e22f1d650b38b83' ;; \
		ppc64le) natsArch='ppc64le'; sha256='dbbd4006d8f4145fb9ae9ed966d7c5474b67686fab4769ebbcba960abb8f7264' ;; \
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

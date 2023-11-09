FROM alpine:3.18

ENV NATS_SERVER 2.10.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='de560b8863ddceac5d765b1f99d4b8f0becf8488890253beafffb7cb730f1aa8' ;; \
		armhf) natsArch='arm6'; sha256='b0ca5676f1b65a60dd7feb0b1be5b7ae35977a978ba21451d0165492c984a93f' ;; \
		armv7) natsArch='arm7'; sha256='0b0695e6f4e90012021e5ef59b71d6a4e0a19df0c5852c83494d7e9776dc5085' ;; \
		x86_64) natsArch='amd64'; sha256='33e9796344fcde53d1d9ab5fc3e2393d1f558aec53f5ea51f769827602a20225' ;; \
		x86) natsArch='386'; sha256='f8d4facfc3735ea46ccaecc1e7815f2b755dd0697b0b7f7d83cff568e2ebd77c' ;; \
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

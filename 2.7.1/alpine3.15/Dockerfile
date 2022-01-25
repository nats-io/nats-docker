FROM alpine:3.15

ENV NATS_SERVER 2.7.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='44033b3e2652a6b56f10d8f7518e6152f026ec77f4937389c9e9b39c1fad664c' ;; \
		armhf) natsArch='arm6'; sha256='e8e31f3c748c65ea475d9e83e04f62e381a87b7aeb8544945b3328d46ed2e798' ;; \
		armv7) natsArch='arm7'; sha256='6445388443988a163b023ff3db8f539f0157fd400981969a383b6a4bf6519d4f' ;; \
		x86_64) natsArch='amd64'; sha256='396e87f3b0f741d9190089766ca6c7fcf696c9282d730e5c1b62e34f84df673c' ;; \
		x86) natsArch='386'; sha256='a354b576ad931a97a6ce5d248bd8013bb8a1077b3f195cf79bfd0069ba03d6a1' ;; \
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

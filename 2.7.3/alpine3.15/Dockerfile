FROM alpine:3.15

ENV NATS_SERVER 2.7.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c895169ab34bc21442121f6c885905a254a9351a098402f319b3fbfd1e6225c9' ;; \
		armhf) natsArch='arm6'; sha256='1b7e1c5835131825c4007766befd0c96a60edbcc3bc336a6739de5c8affea0c4' ;; \
		armv7) natsArch='arm7'; sha256='723290467bc7e95b59ca7238a818932b199b00a21d4e3d7eb0e826b7aba2e0ea' ;; \
		x86_64) natsArch='amd64'; sha256='2186c7660cd1d9774421614f6724ad32d7cec2389e39858f227a7991be41b1a7' ;; \
		x86) natsArch='386'; sha256='3e8e2841921d555d06c67b1e33fc9bd934e4afec4748f7ddf27c67d707fafea4' ;; \
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

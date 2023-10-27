FROM alpine:3.18

ENV NATS_SERVER 2.10.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='38e137d26623cd06687ca560b45a359d184f72418faa8da5185d39aa2251b8c1' ;; \
		armhf) natsArch='arm6'; sha256='9dab52843eed706b19d77db1b60611b0e205c862a913206cc7af3c640bbc67d0' ;; \
		armv7) natsArch='arm7'; sha256='65d1d774d5a41d9df8e37c4578aac0d415363dc2b6eb27ac4adf86921fdea7c9' ;; \
		x86_64) natsArch='amd64'; sha256='bb29fb04df977371ecb9fc3e33d1c9203db4f629a19303fe0c42a69d6ffd40d6' ;; \
		x86) natsArch='386'; sha256='6809cd6423fc05f1296b24730d2b96d2803ba5cb65dcd5a906fc09cf9175d131' ;; \
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

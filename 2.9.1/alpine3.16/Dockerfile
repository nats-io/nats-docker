FROM alpine:3.16

ENV NATS_SERVER 2.9.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='d0aa00133c68e3dd1c791272fe352ba5d5ec097c58991946c5a0e66e06fdca4c' ;; \
		armhf) natsArch='arm6'; sha256='794267eb36c86034b8f800fda1a60019538ac79788ca3e060cbe737dcbe6e8b8' ;; \
		armv7) natsArch='arm7'; sha256='22c9d0304daf83d8ed08431121f4e389954ea9447c39b407d07eee588ac31dc5' ;; \
		x86_64) natsArch='amd64'; sha256='7d2d6a245f3c42b0ac5a75a6cf345235bef534a0baeabeb374b328e08b60a25b' ;; \
		x86) natsArch='386'; sha256='f63cbffde08a8c6716a1dba464a52df48265186e8b0386a4815e7c549143599a' ;; \
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

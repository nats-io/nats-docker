FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='f73de3056832ca1102c22792cf213e1232cf6b17829ecdb0f48cc6fdaee3e625' ;; \
		armhf) natsArch='arm6'; sha256='0cd0ebee32ec5a1ef5abd7081827c5ee73072999bdda8967f35d691174b97a16' ;; \
		armv7) natsArch='arm7'; sha256='b833bdcaedbb7fec4ba1625cfc3e1c07a6c7ddc5901a23e2166f20e9a6a4d9e5' ;; \
		x86_64) natsArch='amd64'; sha256='7a280ab8e0213a4749321f10806fa6878f6277ffae600531fef8e5ecf1d248f0' ;; \
		x86) natsArch='386'; sha256='342bdb643fb9102785af01913192a36f0e215fe568bff084a91bce60511e6aea' ;; \
		s390x) natsArch='s390x'; sha256='40f2ae3b458b45d8ec962c0731a0d961e1414adfee46302601a2a6e6c552b001' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f52ebd3dd3a69def9c709e57a143115794cd229cbc062e22ee12687b0b0336b5' ;; \
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

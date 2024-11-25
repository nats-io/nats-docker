FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='e1ccbe7e1de01a07987f35e81d3a5cb7a54dc21352ac83306fa568ec2fb4b3fb' ;; \
		armhf) natsArch='arm6'; sha256='a6665578728c9d3e95943e9d149098b9fa30914fbc81d9867f5566cf4d70ad89' ;; \
		armv7) natsArch='arm7'; sha256='595272fac8d760ca831db8c1b67f97a473edaf461f0361e96d6b82fe9b003c80' ;; \
		x86_64) natsArch='amd64'; sha256='2c223b5651653bf56dd7a94a37e2d2b12dd9006abc3fb115b20744b7eabeef61' ;; \
		x86) natsArch='386'; sha256='8307863d18300b7b0aeea98a6cfded8ae076b4a18065b800c20251a6d867bf99' ;; \
		s390x) natsArch='s390x'; sha256='6a79c3e69f278c7b42997cc2f05e66d3d0a02dbab6a74585f7f025b3122c5bbc' ;; \
		ppc64le) natsArch='ppc64le'; sha256='11699ad4057d3410ea1b10541f3af91874a8417a26730484abf3e89a635f5518' ;; \
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

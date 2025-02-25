FROM alpine:3.21

ENV NATS_SERVER 2.10.26

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='aba1b169f18d4441b4b5d760805c562dccc57b425a7a213a82753a2269a27235' ;; \
		armhf) natsArch='arm6'; sha256='65a7003e8bfad9e8ba2d34efe8cc33299e754da2134d30b9cffb37561379f9b2' ;; \
		armv7) natsArch='arm7'; sha256='85bfefdd849528df836da8820b46a088c20bbb7cf2ef90dfaa5211a789ac92be' ;; \
		x86_64) natsArch='amd64'; sha256='6cbac67107e69c9e5a352d6f1555027f9da6a6b3fa81cceafefa9598b4451512' ;; \
		x86) natsArch='386'; sha256='fc536de9e39ffe69f3f593e10c34d39a68c1ac98cfd88eff28f8c87dd09ec804' ;; \
		s390x) natsArch='s390x'; sha256='c6f857d0dec8ea44f78efa3b4a7580fb51b7419e32b168bb1cb476527db04971' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d416e0c151959ec896152ded12746e75ff549b9643dbec1e0087b0262c5b959a' ;; \
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

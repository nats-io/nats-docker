FROM alpine:3.21

ENV NATS_SERVER 2.11.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='27c90d8bc0ad10bfb38ef92bdea8528b4bfc5aa56afba91c790fb3921ea205a2' ;; \
		armhf) natsArch='arm6'; sha256='8f9f2f4aa85c242f254a175c9455e9d00c6a0e7fc96b87a14ef3bd6d8762e900' ;; \
		armv7) natsArch='arm7'; sha256='06dee81c2fd32639ae646112daaf9b84b71023bee88b16fd3324fd922095dda1' ;; \
		x86_64) natsArch='amd64'; sha256='f1d9754bf34316d1f7d349b176ff0414c9cce742846bf2eec0b402eee35a638c' ;; \
		x86) natsArch='386'; sha256='b746e832f96f07ee5958c99201b7a96695a3e1339f416342b9fd3c083a68dba7' ;; \
		s390x) natsArch='s390x'; sha256='018ec95e10758c3e6ea14f034d3fe099234957dec8290bc5aa3480a8d77e3e29' ;; \
		ppc64le) natsArch='ppc64le'; sha256='be0f9308ffcdfa36189afdf7e8116235995d7d20406c0fc7b8aa5b5f724aa3d6' ;; \
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

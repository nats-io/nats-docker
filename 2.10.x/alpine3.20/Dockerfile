FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='62de7ffef4d0227673c05a74bad1c6ab9b66ceb9d93245ddc1d3e37b2965c95c' ;; \
		armhf) natsArch='arm6'; sha256='0754574cc2151d13502b43c89f96a92059c21f858589b4ac5e4eb3e66615d479' ;; \
		armv7) natsArch='arm7'; sha256='7d5ee9ae82b34105199bf81affecd3144b0d2d7c61b363be5d1d3d54c097012c' ;; \
		x86_64) natsArch='amd64'; sha256='260f6af11bf099790279283b9f1435c76876a6abb8eeab3ca0fadedcc50fe11b' ;; \
		x86) natsArch='386'; sha256='4a84bbdb551d4a48d6f4557822e682c3ad103a20039a1348e27e4020f302d808' ;; \
		s390x) natsArch='s390x'; sha256='eb49683c169bdadee3735dc5c1973e32df657f36daea0155b84bb2214071c1d9' ;; \
		ppc64le) natsArch='ppc64le'; sha256='4c32dbe5ab89efd0f3db718648424a2b1c8bdb42ed0ca8b14e76828db3c9ba3a' ;; \
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

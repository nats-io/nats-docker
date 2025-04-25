FROM alpine:3.21

ENV NATS_SERVER 2.11.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='da0a4b9d57d2a4c2439f0c8731b7e1ef8f0a7f2a1edf643d5f50a73ffc0c31f9' ;; \
		armhf) natsArch='arm6'; sha256='2370e8d794acb0f176be0f0885f9930fa9d8d1276f15162eb8db336467279bc1' ;; \
		armv7) natsArch='arm7'; sha256='46b038e57ad586f05342dcd3b29a2c2597217c19172a916eef9187170f024ad8' ;; \
		x86_64) natsArch='amd64'; sha256='a123c8e43abe5ca8f0bff9393547f20f4bbac6fc0fb3c586ec031855911c414a' ;; \
		x86) natsArch='386'; sha256='03bf7db9323c453b1257c3a43a21fcd5a975a2cc136c4bbeab7c0e815939e37e' ;; \
		s390x) natsArch='s390x'; sha256='eb40e4a843124198b7e8625b7cccbd52810d63db17e1557d59681f5f29be5a98' ;; \
		ppc64le) natsArch='ppc64le'; sha256='28e2afbca41dffe453507a993291560bfc57c6f43fe435604f894c3d91426dd0' ;; \
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

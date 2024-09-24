FROM alpine:3.20

ENV NATS_SERVER 2.10.21-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='55227bf4e228ba615d5d59218c598cb0de0ae094211d9a3fccaaf8a19821a932' ;; \
		armhf) natsArch='arm6'; sha256='ae5397cfbbb445d2b2b4487a9a827820229a74d5b250e596075cd7bb6882a3ce' ;; \
		armv7) natsArch='arm7'; sha256='15c02941a207b834304b10de4cd6708df20a94ebff596bb6d2e3811da9bec164' ;; \
		x86_64) natsArch='amd64'; sha256='495b087312be7d220d342a2065ac4dbbac558f4b63cce5fd59be77f862d2bf65' ;; \
		x86) natsArch='386'; sha256='6e35f1ca584ecaf81088651d1ea7902383da8c29fef8dfd72b7306fd96102f41' ;; \
		s390x) natsArch='s390x'; sha256='282e672299bebc0c1193c0505ce34a76b7e03f49de282ff52620e382e960d70c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='3a665322afc711ddfdab0a39a36c54a7f622d6d04f7d9c0a646cf6db21715ab0' ;; \
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

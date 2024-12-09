FROM alpine:3.21

ENV NATS_SERVER 2.10.23-RC.12

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ee23acef098e17b035fc362747b5b190c8807b6311e13400478d4759567d88c5' ;; \
		armhf) natsArch='arm6'; sha256='662dec7dc043f5e886ad605c9441092e8c32ba8155bbaf8a3db4f0218b7b4c63' ;; \
		armv7) natsArch='arm7'; sha256='5389790c22a0733872fcbeb7cdce3209245bbf1e069d6b8b5e5985e446b7a5e2' ;; \
		x86_64) natsArch='amd64'; sha256='867875985410b3c3770e783c7fc106ee187618fdebc88b53ba303c7e955e8ecf' ;; \
		x86) natsArch='386'; sha256='20112105af0eca96f9c09e25cda8ee6a309be42499b4251635425b80cb6366f5' ;; \
		s390x) natsArch='s390x'; sha256='82a4f28c7ce89e3e2c89123e8f909e9f97cbc4301dff4f2da8559a727aadd7f3' ;; \
		ppc64le) natsArch='ppc64le'; sha256='3d91721ec6ed6dc7cda5732136bd5b0a2456048e89d59bd500601c6b0c6759a5' ;; \
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

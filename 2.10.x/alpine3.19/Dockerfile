FROM alpine:3.19

ENV NATS_SERVER 2.10.10

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='bbf8b7bc850580a370c9309d0e43ea2b2286e21fa9f5b33dfb751d219275e9e0' ;; \
		armhf) natsArch='arm6'; sha256='9750cf2efb47afd8965a1ec9cd2a96c6d6af0cae70cfefc7b425e030799e1ac5' ;; \
		armv7) natsArch='arm7'; sha256='3d9480c2bb3b0952f628d603855cbde234fe3768c498c5da89e11b8411d2be19' ;; \
		x86_64) natsArch='amd64'; sha256='c8cd7e19b906a5f8a7f9f7e70fc4bfa492d66a069d9664c4db19fdee1b6aa640' ;; \
		x86) natsArch='386'; sha256='99283c58577da02f6f9b0c104298308dfba18039dd48a782efc3be9d10b7bada' ;; \
		s390x) natsArch='s390x'; sha256='e297977d1fc21c021aa989b1eda629dad9947d618558e14acc26f870ea86139a' ;; \
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

FROM alpine:3.21

ENV NATS_SERVER 2.10.25-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='e72d25b08b6b1e591f7947186d672e21dbf82dfe51c7ee5434060c4f7c7bb708' ;; \
		armhf) natsArch='arm6'; sha256='bf21da361181d2cdac3ab15ed50d0a22d8570c0598eb0ee6acf5185faa9fac2a' ;; \
		armv7) natsArch='arm7'; sha256='6326f2d76fd6c9b4021439630035783ee6985f20b0746b3643851f3e2128799c' ;; \
		x86_64) natsArch='amd64'; sha256='809c2cdea4498c0ab025c7f769d74bb2eaf81f0ea12f2bb7ba09a50bfe85d709' ;; \
		x86) natsArch='386'; sha256='0e27016493a6cd9d6190f30bb18e7d23ca9dc978a9a1c72aa4a45a77ff0fcd30' ;; \
		s390x) natsArch='s390x'; sha256='1ee6bf8739f83fb18a1372fbef65a68a2ea0932b184e6deb29e1c4dc7ac6ca7b' ;; \
		ppc64le) natsArch='ppc64le'; sha256='7b8f02a38cc50d79c2efc324f8e60b1640bdb3270098b7d34e03c7b0daf5fd56' ;; \
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

FROM alpine:3.22

ENV NATS_SERVER 2.11.5-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='76e7ed91d8ced874e596ead76fdf17c92fb948f67cfc907753f0a28b932e5fdf' ;; \
		armhf) natsArch='arm6'; sha256='3cdb65e057a920d0c7010f2884efbbcb650bc61f181d2a5559c225bd845e9afa' ;; \
		armv7) natsArch='arm7'; sha256='bc0a67ae3c0aa7548c7c635482e715e3396bde7e40c0f9f55b95ddecce7b10cc' ;; \
		x86_64) natsArch='amd64'; sha256='13093b940b6390b1f6b383e72c821687758359c7cebc5a4d45d29b37db706926' ;; \
		x86) natsArch='386'; sha256='50f91bddf170554c357ced958900ea7d1ce8ab52732826db11628be21bc00889' ;; \
		s390x) natsArch='s390x'; sha256='15768933a48f1d698a57b890c86931e0b50ff6c2e9bbcd5b2a417ccec4387c95' ;; \
		ppc64le) natsArch='ppc64le'; sha256='f1df758d557601cc38f0c15d574f9bbcf518750ab5a6202286a83a58b680c5f5' ;; \
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

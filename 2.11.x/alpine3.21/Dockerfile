FROM alpine:3.21

ENV NATS_SERVER 2.11.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='d286af6454cc78bd29acee5f46f212ee683adefab2694d338aeea0ba86e27f1b' ;; \
		armhf) natsArch='arm6'; sha256='3d5edd81050b590ce1b7481a22601865dfaf486ad7d7f4b8b96e76ff7a667027' ;; \
		armv7) natsArch='arm7'; sha256='bcc8bc70401258f4c4bbf992d1a5288a6ee037f5e7943de8fc23771bae43addb' ;; \
		x86_64) natsArch='amd64'; sha256='8e486041359de5bb562c16604c3815d88d99efed77c338b1c96efa46856a8b98' ;; \
		x86) natsArch='386'; sha256='1795f409990125677ba659b993bfd5a567b5c473d2dc2694aa47a55af669bc3a' ;; \
		s390x) natsArch='s390x'; sha256='2c1ca2b6d8fb8a3560d906be7953a270164f7e7f7d23a63a8d579a7bc6e22a79' ;; \
		ppc64le) natsArch='ppc64le'; sha256='b8e542b5de2279c835a7d1f70c6cab26c9698e226156d3b6cfcb8f58edd6f243' ;; \
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

FROM alpine:3.20

ENV NATS_SERVER 2.10.19-RC.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='fbdc7f5aad6d2cd9304ba72d0ed6c021ca1b0f0ad5cef069a465036692cd40dd' ;; \
		armhf) natsArch='arm6'; sha256='55f32bf8194b9f91f453c11ce74fb2a7188fa42683babe93f7fa8db98b2013c9' ;; \
		armv7) natsArch='arm7'; sha256='46cb669883069df7e0774b34ca92334b25c716ab52e72a8ecdd33461447cf660' ;; \
		x86_64) natsArch='amd64'; sha256='d2ed4b459c2d5016bc543692b71279d0950be1fe7b57338101470c265e895c4d' ;; \
		x86) natsArch='386'; sha256='2defd3c54ede747c8a70713a0cde1168a6f27525d2de0ed7b8035bd5d797e27c' ;; \
		s390x) natsArch='s390x'; sha256='dd304afe7b70765847841a4b77461d19e0099531028bcc7a2deaa87aa15d4d47' ;; \
		ppc64le) natsArch='ppc64le'; sha256='a1a769461ce3e06f65f7f0a83bc00538601d71adc44c4127a0f26d56f7c091b0' ;; \
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

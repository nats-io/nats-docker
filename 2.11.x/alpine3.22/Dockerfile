FROM alpine:3.22

ENV NATS_SERVER 2.11.5-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='deadf68d18c40921755607ca8e5fd08e22254f47d7ef10528108bc05d4ffd102' ;; \
		armhf) natsArch='arm6'; sha256='6b19581676ea004c0272be2a3a281b3b1e39c4f301c7f74c44c7702888dbeb84' ;; \
		armv7) natsArch='arm7'; sha256='204ae1eb030d6c62b439d13416a5b52bb5a1ddfc0acfa6326f78fcfb7fb24162' ;; \
		x86_64) natsArch='amd64'; sha256='4a3a59ae47d51621fbde1d5e2636055cdc5717a1be54a73daec2d6a339176520' ;; \
		x86) natsArch='386'; sha256='2fcf4619277d8253a7528cd6635d430ce092bd928448a5bad525273be5ccc523' ;; \
		s390x) natsArch='s390x'; sha256='112bd0539f22984d6795217115fc956a151a8578d7a8c0f3ccecee0b00a8978c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='0f99ac7cd198bcfbe810dddc42caaf4abf336a397f27b42736cbcf8a13e81d34' ;; \
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

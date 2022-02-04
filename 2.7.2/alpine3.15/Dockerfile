FROM alpine:3.15

ENV NATS_SERVER 2.7.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='7160b8fce84427cb9da6862e365ccaf1c5bcc1ab37c5a74a50bbf1c18dd0cef3' ;; \
		armhf) natsArch='arm6'; sha256='8e74741ad48b680a9fad05af30d352fb316754feb37ef7a84d5d660a69d5ba1e' ;; \
		armv7) natsArch='arm7'; sha256='b1bb6a5e9159e37efc8c823a217c343d0580564c2e836d07c93b43633bb46245' ;; \
		x86_64) natsArch='amd64'; sha256='6f58d9df9d9ab47d93ecb06d1041c86a784fc61c3475ab994e144e8ae15584d9' ;; \
		x86) natsArch='386'; sha256='5276a5af79f6e9b8a07c6c63886386f8d154f38ab743a8f929b64dad38056b9a' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-server.tar.gz "https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
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

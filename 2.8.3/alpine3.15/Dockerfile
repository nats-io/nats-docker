FROM alpine:3.15

ENV NATS_SERVER 2.8.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='905df5647dba0443ce6b92116ff5c6ceb49d3e24fa78c999d0c19fe634f341d6' ;; \
		armhf) natsArch='arm6'; sha256='590a0460362ab1fc47ebce8886f5a53ff8b91abefa412ce77762f8514041394b' ;; \
		armv7) natsArch='arm7'; sha256='142673f4eafca832e0347b1be0f5f9b0b7b23a46c08a623b63c6925a94a2d9f1' ;; \
		x86_64) natsArch='amd64'; sha256='16e6bfa14e8ba9bc7d924e296bfe6bcad803b04318e6d60ef14ee45e3d3ddc60' ;; \
		x86) natsArch='386'; sha256='fc749ab7574aa9ae22661a89ad73ac26331772e2302197d1625db56e967a74ac' ;; \
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

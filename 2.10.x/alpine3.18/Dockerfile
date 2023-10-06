FROM alpine:3.18

ENV NATS_SERVER 2.10.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='26b3816709136a8d061e5147cfb217abb577d1fd79e08689417c9b0fa2806533' ;; \
		armhf) natsArch='arm6'; sha256='189131c2b890446d88b508cc7e8aa937c38fef81dbd3f4b4d3d205af41edb5ab' ;; \
		armv7) natsArch='arm7'; sha256='33374ac52531ac0a8c57c2f111d098eb99c42120fedfad57317817e6d48d70d2' ;; \
		x86_64) natsArch='amd64'; sha256='8929b053d2dca2b62756982951c51147b69be984b55a7a850affa86a66c6bfc9' ;; \
		x86) natsArch='386'; sha256='b11c6bded174332b3fc88ac40c3632448d58e8d58dc92551d9655407ce0107e8' ;; \
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

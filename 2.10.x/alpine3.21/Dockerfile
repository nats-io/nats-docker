FROM alpine:3.21

ENV NATS_SERVER 2.10.23

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='a267a45cb12deb5bbe5c849ae26b2fc020a86109d62fe94538f6b6550cad620a' ;; \
		armhf) natsArch='arm6'; sha256='ad01e4689d6c34a7884f8ffce3ae096b898d466c1bccf1f7f3202002556ed89c' ;; \
		armv7) natsArch='arm7'; sha256='a456380e4616be5b3f9afc6eecf1343050eb1ffc4fa73c848df009ff44710468' ;; \
		x86_64) natsArch='amd64'; sha256='a79fd5a82ff9fc02f0a9619b121bbdf28f02002163170abef31c81c19a1d3014' ;; \
		x86) natsArch='386'; sha256='f40c95d2a1c4133e45421f14c46919427e293ef69ac1b45f63e5b79d2dd09021' ;; \
		s390x) natsArch='s390x'; sha256='fa6a5dfa508bec90392754db648d497c8e00192fecf9e36a02a12f757097693c' ;; \
		ppc64le) natsArch='ppc64le'; sha256='539a945e9dea88435cd7124afa516a7150c05cbb3e279eb6ac7c359688f970e5' ;; \
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

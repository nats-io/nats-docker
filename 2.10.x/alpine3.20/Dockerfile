FROM alpine:3.20

ENV NATS_SERVER 2.10.17

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='0f4f178ff37716396f0451aee98a9c9f7166d5b79c4bb12580a16e32e2e0f128' ;; \
		armhf) natsArch='arm6'; sha256='2a47d80a090582ece7933a44600493e66d163322224f79eee64a824685c4eb53' ;; \
		armv7) natsArch='arm7'; sha256='56579ff08e6b2bf69f1d4115715653f08faf78ad58f4ed42c3eaec69976e93d2' ;; \
		x86_64) natsArch='amd64'; sha256='e712569650b2adddfd57c8c1606e6d927e68601f3cc86bb95224b3446aebc2f6' ;; \
		x86) natsArch='386'; sha256='4714a3b4e948a91a7e974eea9c995e15166ba5c3ba6ec80757044b8f9fba4bff' ;; \
		s390x) natsArch='s390x'; sha256='1dd52cec5bc405fae3e65661431e89de049342b157244567cd3e36bae23799f3' ;; \
		ppc64le) natsArch='ppc64le'; sha256='c8bc98611c8b1e5e34e852740653208b3afc1975a8e1c1ba4b7fb8e202255cc1' ;; \
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

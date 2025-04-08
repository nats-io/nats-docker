FROM alpine:3.21

ENV NATS_SERVER 2.10.27

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='47067e41dc27890d9665ddf429ce24f9ed50bddd035dee63b915fcfcb1f8043b' ;; \
		armhf) natsArch='arm6'; sha256='4e4268d1bb83568217f8dbce77d5e0ca93cea8282d6fef796b505cdd2b16cb64' ;; \
		armv7) natsArch='arm7'; sha256='a1dc4d8ff0a1e61aa80c9b50f5aa45dac3a3126e70d0c2ae5f53119dcf697503' ;; \
		x86_64) natsArch='amd64'; sha256='0c3f53edaf1acccc41866d49d9c3626c9de8c9138b2fc11bbadfd3a4eb544ef1' ;; \
		x86) natsArch='386'; sha256='f6b515da90da16bf09570d9dc67ef1488aaa75334c559c4c71371527242c5511' ;; \
		s390x) natsArch='s390x'; sha256='f6864ce2b8fe25359ff9a307fabc88201e113b8c57634be2893d7bfafe425525' ;; \
		ppc64le) natsArch='ppc64le'; sha256='29c22b82c139baca9231c30f9a4a61f0f6df9407d67971c035a5ad45eb4296cf' ;; \
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

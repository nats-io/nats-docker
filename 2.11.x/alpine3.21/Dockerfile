FROM alpine:3.21

ENV NATS_SERVER 2.11.1-binary

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='2499105f9e64bef55f168f634d34a586b710f6ac041639d8a18364f2b4f4c410' ;; \
		armhf) natsArch='arm6'; sha256='31bc11906458e30c8028cdd0301de98713074db73f5e352f58ce4ecd6b1cc641' ;; \
		armv7) natsArch='arm7'; sha256='432f4c47cf5adca05da67f1feaf969f6cea50ed9c3bb743a8bb76b8c5c583c8e' ;; \
		x86_64) natsArch='amd64'; sha256='827497f99acd54eb0e4e8bfa3b0eb31dd51c6c259110de11a45a7fdacae6c5b3' ;; \
		x86) natsArch='386'; sha256='651065e2170ee0f7e244425c0d0ba30a38776a7aef75e2d5cba0b8b11a950c54' ;; \
		s390x) natsArch='s390x'; sha256='23e6ce6b70f9b973106d325eebb8bdd613040bedd4da980ff0aea2d2a7dc122e' ;; \
		ppc64le) natsArch='ppc64le'; sha256='5341f41ef6298b05b72dd77c1ec055aeacb1b57dfd600ec888317347b3b4cbf8' ;; \
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

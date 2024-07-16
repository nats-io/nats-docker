FROM alpine:3.20

ENV NATS_SERVER 2.10.18-RC.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='8d489d8a902c90dd2633b73122a3f43a782b474db5f448a4e92223b60fd68eb8' ;; \
		armhf) natsArch='arm6'; sha256='271df2b5d09f32119ab7399f693db0065413c08a62c714fafa7519e4a90d72c4' ;; \
		armv7) natsArch='arm7'; sha256='37a21ea95ff949835e223f01b47696932748011e5023cfe9adcea0bd68e7e0ee' ;; \
		x86_64) natsArch='amd64'; sha256='e640a9b89a3ee36ac12c5dd6f821c101aa6ce5b2745a76839c9f338b143f8ca4' ;; \
		x86) natsArch='386'; sha256='fa5e327457dec5080d60017ec185d218123e5b652f496c40f2600caa96c135f8' ;; \
		s390x) natsArch='s390x'; sha256='7261217ffb43f01fffdc24e3ce8fc23425993edfa739da723e419f6097898b94' ;; \
		ppc64le) natsArch='ppc64le'; sha256='4dbd4d3a5c701fa8b1f60e8dfaf55755206abed7d42bffacf6a73ebdbe470bc6' ;; \
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

FROM alpine:3.21

ENV NATS_SERVER 2.10.26-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='2f3a6ed425114688b4d3279a7c8ea4e3a3e66e79840a25f8e64c58191bd397e5' ;; \
		armhf) natsArch='arm6'; sha256='2aede9b45f9787da235edcc277a226613b23aa723ad29e7526e63c63cc604c94' ;; \
		armv7) natsArch='arm7'; sha256='e2ce5c609f431021b58fca5001e50c4f38ec325558a1eb771d8ed84c1210f234' ;; \
		x86_64) natsArch='amd64'; sha256='8ea3d272b4c722389b0cc81e2207eadfa51288793810a27f989e6264a90e452d' ;; \
		x86) natsArch='386'; sha256='74a775831ac63615cf97e869f4a64f0912203ca54d7a0d819dc05b5c228ddd85' ;; \
		s390x) natsArch='s390x'; sha256='4ad1cba25f79c166920679f914a95da0f854e4dc2b26e77efb355c4d441df053' ;; \
		ppc64le) natsArch='ppc64le'; sha256='8a509e12f7650d6f18fa95d88952c6ef99c01a1c7174f239cc247bbc9418b06d' ;; \
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

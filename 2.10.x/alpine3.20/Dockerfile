FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c4e2ccd5985773612d4ae5a2e27ea06d389e9086d084736a84043902d99dcda2' ;; \
		armhf) natsArch='arm6'; sha256='6b75bfd29dcac3fb5433b70a157a99c3aa8f561a47972f813e9873eb89037498' ;; \
		armv7) natsArch='arm7'; sha256='da4cc1388096086be3cc80e1e1a552fb3d565df4d8358a885a75b7533c588df7' ;; \
		x86_64) natsArch='amd64'; sha256='6664ba97c9f2644ab03ba22c2dc728afff6107ab588f9100113aac698c17c2e3' ;; \
		x86) natsArch='386'; sha256='393dc89d9486b843feba21266bab37c38cc9fd2d57aae82ed1c35159ade18c4b' ;; \
		s390x) natsArch='s390x'; sha256='0031e1739432f126648a4c5fe7b52e41ba17309f293b60153547e3052d8c3d15' ;; \
		ppc64le) natsArch='ppc64le'; sha256='d350be45ba196f89fffdc6b7c33e9d1a8a9a9e9d916146f267c9fb0ce08cbaf6' ;; \
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

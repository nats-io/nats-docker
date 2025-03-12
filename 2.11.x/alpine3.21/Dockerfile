FROM alpine:3.21

ENV NATS_SERVER 2.11.0-RC.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='d449838dc626612778c9cd23344491b7ab30637d0e81aa65c69dea7bb48ce444' ;; \
		armhf) natsArch='arm6'; sha256='21e61f23c2b31ef746b99d0f7562898224b799d2ef204fbec3e00dc54d968ee1' ;; \
		armv7) natsArch='arm7'; sha256='7dda3c185c41356374b57503b0db65065ef71e1e760cf6a74fe1d5ae9276255d' ;; \
		x86_64) natsArch='amd64'; sha256='3ae338d017094db041e97a3d17e72b55e978b82da45913b52a6eb42789a846df' ;; \
		x86) natsArch='386'; sha256='a755922c0eb57d15d59a186a5b015a3c7658fc8009fc977f4b80b142a08d355a' ;; \
		s390x) natsArch='s390x'; sha256='6e64a9222fbe376e9d2957bbe1e60f872cdb106a2c79e0a5cb7293025f0aa24f' ;; \
		ppc64le) natsArch='ppc64le'; sha256='31fa31fef72f7d94e423ced0e8d7e11b0322f5d9a6b543abca704234a6bf35b4' ;; \
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

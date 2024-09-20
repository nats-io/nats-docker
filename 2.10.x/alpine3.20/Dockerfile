FROM alpine:3.20

ENV NATS_SERVER 2.10.21-RC.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='c5ae52acdb11020c7dec7a7c1bdd2a396399434dcfb6e8ae4524b6483d8a0af3' ;; \
		armhf) natsArch='arm6'; sha256='d81aa0516265d9224dd8350763ede8938e4d070e0e071b9ae9c146430150b7bd' ;; \
		armv7) natsArch='arm7'; sha256='a8f8788c273ba56d30a50c4f1001b9e3d2b982d2c917b04367b28d12116e21aa' ;; \
		x86_64) natsArch='amd64'; sha256='3389945adbe112af2743421a4f91d430b4d10d52ea1520538090145ac1b08c6e' ;; \
		x86) natsArch='386'; sha256='5a9baf4ef140d1fbbae85265e1c396f2ea59f8dc33db376d4a68f40acdd7901c' ;; \
		s390x) natsArch='s390x'; sha256='57967a9e9a457d9db05abb4259b9d050b031d3aed5458d20d39389a54d632a65' ;; \
		ppc64le) natsArch='ppc64le'; sha256='36b7a7dac4e5f9e903ef2a6fdb8a103fe96c33f59131ab2a6e79cb237c0620be' ;; \
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

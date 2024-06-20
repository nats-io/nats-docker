FROM alpine:3.20

ENV NATS_SERVER 2.10.17-RC.6

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='1be7350536106c80b5985808d1e1d43831d679da5af380205fd78725705446f4' ;; \
		armhf) natsArch='arm6'; sha256='a80bff71bd8b2785b74cd12aa33e1526d61d3193d4690b46bdce09b17ad5bdc9' ;; \
		armv7) natsArch='arm7'; sha256='414ef0f80be166ddb9e1fc7ddcde19f032a7136371b573ae29aaa2776205870b' ;; \
		x86_64) natsArch='amd64'; sha256='a07e2238a27773066897f624055a4a4798dba6692ab2c7b305f62b3fc9ac0db0' ;; \
		x86) natsArch='386'; sha256='8a76b55788d2f7255847c78b4f42bc07ed3ef25ca73759f4cc468ac89fa9342d' ;; \
		s390x) natsArch='s390x'; sha256='05efb0ff45f2f58c047aec242c193f3435ac509824b3d2e6ea8140156df01be9' ;; \
		ppc64le) natsArch='ppc64le'; sha256='fbcaf7fa6492b9d89c7721772d1c815ba6c3a5a0d823ff55c7618f0f45ce5a83' ;; \
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

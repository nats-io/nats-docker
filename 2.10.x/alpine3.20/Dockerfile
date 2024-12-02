FROM alpine:3.20

ENV NATS_SERVER 2.10.23-RC.8

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='72cad4f240319e0f0b5194191cdfcd81682d69eca31075ea08b86c7505528b23' ;; \
		armhf) natsArch='arm6'; sha256='9a38bca524ad15e8f328aeb51fde99afe8999140ab0c8ced31274d5b9e03e97d' ;; \
		armv7) natsArch='arm7'; sha256='4c595c281b28dfb21a1b4035da99c0e3e34e094b0f1254ef27c20e8152466571' ;; \
		x86_64) natsArch='amd64'; sha256='4a32e09b41ba972b57d6faf9b8f265366fa0f7870660cf54f69ab3b5446be509' ;; \
		x86) natsArch='386'; sha256='a0f7fa2050ced70d5bffb0510add68bdb7568850add24bbc2f08fe548cf620b1' ;; \
		s390x) natsArch='s390x'; sha256='1b6ed4ad1291cd924d60c5d7222faadf855a87be2c3d4737362760c75d51f9b7' ;; \
		ppc64le) natsArch='ppc64le'; sha256='0eebd8891fe97219cf03e3bb97bbed102fae5181bcd6f4078eb11d3c7e1156a8' ;; \
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

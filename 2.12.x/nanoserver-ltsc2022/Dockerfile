FROM mcr.microsoft.com/windows/nanoserver:ltsc2022
ENV NATS_DOCKERIZED 1

COPY --from=nats:2.12.5-RC.2-windowsservercore-ltsc2022 C:\\nats-server.exe C:\\nats-server.exe
COPY nats-server.conf C:\\nats-server.conf

EXPOSE 4222 8222 6222
ENTRYPOINT ["C:\\nats-server.exe"]
CMD ["--config", "nats-server.conf"]

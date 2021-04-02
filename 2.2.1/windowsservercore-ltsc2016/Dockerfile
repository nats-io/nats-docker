FROM mcr.microsoft.com/windows/servercore:ltsc2016

# Enable exit on error.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV NATS_DOCKERIZED 1
ENV NATS_SERVER 2.2.1
ENV NATS_SERVER_DOWNLOAD https://github.com/nats-io/nats-server/releases/download/v${NATS_SERVER}/nats-server-v${NATS_SERVER}-windows-amd64.zip
ENV GIT_DOWNLOAD_SHA256 1f0d48a7ba9200e2572016a9f3e1ec7e630f0518cc0b40950c14ff3a5d900924

RUN Set-PSDebug -Trace 2

RUN Write-Host ('downloading from {0} ...' -f $env:NATS_SERVER_DOWNLOAD); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $env:NATS_SERVER_DOWNLOAD -OutFile nats.zip; \
	\
	Write-Host ('verifying sha256 ({0}) ...' -f $env:GIT_DOWNLOAD_SHA256); \
	if ((Get-FileHash nats.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) { \
		Write-Host 'FAILED!'; \
		exit 1; \
	}; \
	Write-Host 'extracting nats.zip'; \
	Expand-Archive -Path 'nats.zip' -DestinationPath .; \
	\
	Write-Host 'copying binary'; \
	Copy-Item nats-server-v*/nats-server.exe -Destination C:\\nats-server.exe; \
	\
	Write-Host 'cleaning up'; \
	Remove-Item -Force nats.zip; \
	Remove-Item -Recurse -Force nats-server-v*; \
	\
	Write-Host 'complete.';

COPY nats-server.conf C:\\nats-server.conf

EXPOSE 4222 8222 6222
ENTRYPOINT ["C:\\nats-server.exe"]
CMD ["--config", "nats-server.conf"]

# nats-docker Windows Variants

These Dockerfiles are for building NATS images for Windows Docker containers. 

The Windows variants are tags of the official [nats](https://registry.hub.docker.com/_/nats/) image:

- `nats:nanoserver` - a lightweight option built on `mcr.microsoft.com/windows/nanoserver:1803`
- `nats:nanoserver-1809` - a lightweight option built on `mcr.microsoft.com/windows/nanoserver:1809`
- `nats:windowsservercore` - a full Windows OS version built on `mcr.microsoft.com/windows/servercore:ltsc2016`

You should use `nats:nanoserver`, unless you are extending this image and need the extra functionality available in `nats:windowsservercore`.


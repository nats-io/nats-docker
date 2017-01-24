# nats-docker Windows Variants

These Dockerfiles are for building NATS images for Windows Docker containers. 

The Windows variants are tags of the official [nats](https://registry.hub.docker.com/_/nats/) image:

- `nats:nanoserver` - a lightweight option built on `microsoft/nanoserver`
- `nats:windowsservercore` - a full Windows OS version built on `microsoft:windowsservercore`

You should use `nats:nanoserver`, unless you are extending this image and need the extra functionality available in `nats:windowsservercore`.


# nats-docker

[![License][License-Image]][License-Url]

This is the Git repo of the official Docker image for [nats]. See the Hub page
for the full readme on how to use this Docker image and for information
regarding contributing and issues.

## nats-docker Windows Variants

These Dockerfiles are for building NATS images for Windows Docker containers.

The Windows variants are tags of the official [nats] image:

* `nats:nanoserver` - a lightweight option built on
  `mcr.microsoft.com/windows/nanoserver:1803`
* `nats:nanoserver-1809` - a lightweight option built on
  `mcr.microsoft.com/windows/nanoserver:1809`
* `nats:windowsservercore` - a full Windows OS version built on
  `mcr.microsoft.com/windows/servercore:ltsc2016`

You should use `nats:nanoserver`, unless you are extending this image and need
the extra functionality available in `nats:windowsservercore`.

## Updating

```
# Rename the directory.
mv 2.1.0 2.1.1

# Alternatively, copy it into a new directory to support multiple versions.
cp -r 2.1.0 2.1.1

# Update the NATS server version with this command.
sed --in-place 's/SERVER_VERSION 2.1.0/SERVER_VERSION 2.1.1/g' \
	$(grep --files-with-matches --recursive "SERVER_VERSION" *)

# Update the Go version in build image with this command.
sed --in-place 's/golang:1.12.9/golang:1.12.10/g' \
	$(grep --files-with-matches --recursive "golang:" *)
```

## License

Unless otherwise noted, the NATS source files are distributed
under the Apache Version 2.0 license found in the LICENSE file.

[License-Url]: https://www.apache.org/licenses/LICENSE-2.0
[License-Image]: https://img.shields.io/badge/License-Apache2-blue.svg
[nats]: https://registry.hub.docker.com/_/nats/

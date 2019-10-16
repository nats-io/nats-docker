# nats-docker

[![License][License-Image]][License-Url]

This is the repo for building the official [NATS server Docker images]. If you
just want to use NATS server, then head over to [Docker Hub]. You don't need
this repo.

The rest of this readme is for image maintainers.

## Directory structure

The directories are structured in a way such that each NATS server release has
a directory. Each release version has a number of base image variants, such as
scratch on Linux or nanoserver on Windows.

```
nats-docker/
├── 1.2.3
│   ├── image variant
└───└── image variant
```

For the most part, image variant Dockerfiles will download the official NATS
server [release binaries] when building the server image and `COPY` a default
configuration file.

The Linux scratch image is special though. Since it's mostly air, we
build the binaries locally. The scratch directory contains subdirectories for
different architectures.

## Updating NATS server version

First, make sure you've published a new NATS server git tag and make sure the
[release binaries] are ready to download.

Next, run this command. `update-server-version.sh` will update Dockerfiles and
anything else to the version you specify.

In addition, the scratch binaries will be built. We will fetch the server
version tag and use the specified Go version to build the binaries.

```
usage ./update-server-version.sh <server version> <go version>
      ./update-server-version.sh 2.1.1 1.13.1
```

This script doesn't update everything though. Here are some other things you
may or may not want to update.

* The Ubuntu host version used for CI.
* The Windows host versions used for CI.

After you've updated everything that needs updating. Submit a PR to this repo.
Make sure CI passes.

## Publishing on Docker Hub

To publish your new changes to Docker Hub. Head over to
[docker-library/official-images]. You'll need to update the [nats IMF] file.

IMF stands for Internet Message Format. It's the format that Docker chose to
declare images, instead of something like YAML.

You'll need to update the git commit in this file.

```
GitCommit: 710f0ed18645d78e97fa7fd8cdf9b80dbe936eb6
```

Also handy to know, if you're testing and haven't merged your PR in
nats-io/nats-docker. You can tell Docker to pull a commit from a different
branch like this.

```
GitFetch: refs/heads/mybranch
GitCommit: 710f0ed18645d78e97fa7fd8cdf9b80dbe936eb6
```

Docker images will be built in the order they're specified in the IMF file.
This detail is especially important for the Windows images. Nanoserver images
copy a binary from servercore images. This means a servercore image *must* come
before a corresponding nanoserver image.

```
Tags: 2.1.0-servercore1803, servercore1803
Architectures: windows-amd64
Directory: 2.1.0/servercore1803
Constraints: windowsservercore-1803

Tags: 2.1.0-nanoserver1803, nanoserver1803
Architectures: windows-amd64
Directory: 2.1.0/nanoserver1803
Constraints: nanoserver-1803, windowsservercore-1803
```


[Docker Hub]: https://hub.docker.com/_/nats
[docker-library/official-images]: https://github.com/docker-library/official-images
[License-Image]: https://img.shields.io/badge/License-Apache2-blue.svg
[License-Url]: https://www.apache.org/licenses/LICENSE-2.0
[nats IMF]: https://github.com/docker-library/official-images/blob/master/library/nats
[NATS server Docker images]: https://hub.docker.com/_/nats
[release binaries]: https://github.com/nats-io/nats-server/releases

#!/usr/bin/env bash
set -exo pipefail

if [[ "$(pwd)" != *"/scratch" ]]; then
	echo "$0 must be run inside of the scratch directory"
	exit 1
fi

go_version="${1}"
if [[ "${go_version}" == "" ]]; then
	echo "usage: ${0} <go version>"
	echo "       ${0} 1.12.9"
	exit 1
fi

# get-scratch-bins.sh builds different architecture NATS server binaries from
# source inside of a Go container. These binaries are then exposed to the host
# and checked into this repo.
#
# The reason we do this and not use the official release binaries is so we can
# disable CGO. We have to disable CGO in order to run NATS inside of a scratch
# container.
#
# Note 'EOF' means that the heredoc is sent as a string literal. No variable
# expansion happens from the super shell.

docker run --interactive --rm --volume "$(pwd)":/out "golang:${go_version}" bash << 'EOF'
	set -ex
	mkdir -p /go/src/github.com/nats-io/nats-server
	cd /go/src/github.com/nats-io/nats-server

	# Version done this way so it's easy to search and replace. This is the
	# format that the Dockerfiles have for specifying the version.
	ver=( NATS_SERVER 2.1.0 )
	git clone --branch "v${ver[1]}" --depth 1 https://github.com/nats-io/nats-server.git .

	export CGO_ENABLED=0
	export GO111MODULE=off

	commit="$(git rev-parse --short HEAD)"

	GOARCH=amd64 go build -o /out/amd64/nats-server -v -a -tags netgo -installsuffix netgo \
		-ldflags "-s -w -X github.com/nats-io/nats-server/server.gitCommit=${commit}"
	GOARCH=arm64 go build -o /out/arm64v8/nats-server -v -a -tags netgo -installsuffix netgo \
		-ldflags "-s -w -X github.com/nats-io/nats-server/server.gitCommit=${commit}"
	GOARCH=arm GOARM=6 go build -o /out/arm32v6/nats-server -v -a -tags netgo -installsuffix netgo \
		-ldflags "-s -w -X github.com/nats-io/nats-server/server.gitCommit=${commit}"
	GOARCH=arm GOARM=7 go build -o /out/arm32v7/nats-server -v -a -tags netgo -installsuffix netgo \
		-ldflags "-s -w -X github.com/nats-io/nats-server/server.gitCommit=${commit}"
EOF

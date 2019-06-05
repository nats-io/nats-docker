#!/bin/bash

set -e

if [ $# -eq 0 ] ; then
	echo "Usage: ./update.sh <nats-io/gnatsd tag or branch>"
	exit
fi

VERSION=$1

# cd to the current directory so the script can be run from anywhere.
cd `dirname $0`

echo "Fetching and building gnatsd $VERSION..."

# Create a tmp build directory.
TEMP=/tmp/nats.build
mkdir $TEMP

git clone -b $VERSION https://github.com/nats-io/nats-server $TEMP

docker build -t nats-builder -f $TEMP/Dockerfile.all $TEMP

# Create a dummy nats builder container so we can run a cp against it.
ID=$(docker create nats-builder)

# Update the local binaries.
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/linux-amd64/nats-server amd64/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/linux-arm6/nats-server arm32v6/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/linux-arm7/nats-server arm32v7/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/linux-arm64/nats-server arm64v8/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/win-amd64/nats-server.exe windows/nanoserver/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/win-amd64/nats-server.exe windows/nanoserver2019/
docker cp $ID:/go/src/github.com/nats-io/nats-server/pkg/win-amd64/nats-server.exe windows/windowsservercore/

# Cleanup.
rm -fr $TEMP
docker rm -f $ID
docker rmi nats-builder
echo "Done."

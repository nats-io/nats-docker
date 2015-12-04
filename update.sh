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

git clone -b $VERSION https://github.com/nats-io/gnatsd $TEMP

docker build -t nats-builder $TEMP

# Create a dummy nats builder container so we can run a cp against it.
ID=$(docker create nats-builder)

# Update the local binary.
docker cp $ID:/go/bin/gnatsd .

# Cleanup.
rm -fr $TEMP
docker rm -f $ID
docker rmi nats-builder

echo "Done."

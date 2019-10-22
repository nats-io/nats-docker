#!/usr/bin/env bash
set -e

# sedi is a cross platform sed. It's necessary because macOS and Linux sed are
# different. :(
sedi () {
	sed --version >/dev/null 2>&1 && sed --in-place -- "$@" || sed -i "" "$@"
}

if [[ "$(pwd)" != *"nats-docker" ]]; then
	echo "$(basename ${0}) must be run from the repo top level"
	exit 1
fi

current_version=$(ls -1 | sort | head -n 1)
new_version="${1}"
if [[ "${new_version}" == "" ]]; then
	echo "usage: ${0} <server version>"
	echo "       ${0} 2.1.0"
	exit 1
fi

echo "current version: ${current_version}"
echo "new version: ${new_version}"

echo "updating files..."
files=$(grep --recursive --binary-files=without-match --files-with-matches "NATS_SERVER ${current_version}" ./*)
sedi "s/NATS_SERVER ${current_version}/NATS_SERVER ${new_version}/g" $files

files=$(grep --recursive --binary-files=without-match --files-with-matches "nats:${current_version}" ./*)
sedi "s/nats:${current_version}/nats:${new_version}/g" $files

echo "renaming directory..."
git mv "${current_version}" "${new_version}"

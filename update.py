#!/usr/bin/env python3

import os
import re
import sys
import typing
import urllib.request

def nats_server_env_list(ver: str) -> typing.List:
    return [
        f"./{ver}/windowsservercore-1809/Dockerfile",
        f"./{ver}/alpine3.18/Dockerfile",
        "./tests/build-images.sh",
        "./tests/build-images-2019.ps1",
    ]

def nats_tag_list(ver: str) -> typing.List:
    return [
        f"./{ver}/scratch/Dockerfile",
        f"./{ver}/nanoserver-1809/Dockerfile",
        "./tests/build-images.sh",
        "./tests/run-images-2019.ps1",
        "./tests/run-images.sh",
        "./tests/build-images-2019.ps1",
    ]

def nats_server_shasum_env_list(ver: str) -> typing.List:
    return [
        f"{ver}/windowsservercore-1809/Dockerfile",
    ]

def update_nats_server_env(old_ver: str, new_ver: str):
    files = nats_server_env_list(old_ver)

    r = re.compile(r"(NATS_SERVER )[0-9]+\.[0-9]+\.[0-9]+")

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{new_ver}", data))

def update_nats_tag(old_ver: str, new_ver: str):
    files = nats_tag_list(old_ver)

    r = re.compile(r"(nats:)[0-9]+\.[0-9]+\.[0-9]+")

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{new_ver}", data))

def update_nats_server_shasum_env(old_ver: str, new_ver: str, shasums: typing.Dict):
    files = nats_server_shasum_env_list(old_ver)

    key = f"nats-server-v{new_ver}-windows-amd64.zip"
    sha = shasums[key]

    r = re.compile(r"(NATS_SERVER_SHASUM )[A-Fa-f0-9]{64}")

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{sha}", data))

def update_alpine_arch_shasums(old_ver: str, new_ver: str, shasums: typing.Dict):
    file = f"{old_ver}/alpine3.18/Dockerfile"
    with open(file, "r") as fd:
        data = fd.read()

    for arch in ["arm64", "arm6", "arm7", "amd64", "386"]:
        key = f"nats-server-v{new_ver}-linux-{arch}.tar.gz"
        arch_sha = shasums[key]
        r = re.compile(f"(natsArch='{arch}'; )"+r"sha256='[A-Fa-f0-9]{64}'")
        data = r.sub(f"\g<1>sha256='{arch_sha}'", data)

    with open(file, "w") as fd:
        fd.write(data)

def get_shasums(ver: str) -> typing.Dict:
    u = f"https://github.com/nats-io/nats-server/releases/download/v{ver}/SHA256SUMS"
    with urllib.request.urlopen(u) as resp:
        data = resp.readlines()

    d = {}
    for line in data:
        sps = line.split()
        if len(sps) != 2:
            continue
        d[sps[1].decode("utf-8")] = sps[0].decode("utf-8")
    return d

def get_current_version(dir: str) -> str:
    r = re.compile(r"[0-9]+\.[0-9]+\.[0-9]+")
    for f in os.listdir(dir):
        if r.search(f):
            return f
    return ""

if __name__ == "__main__":
    if len(sys.argv) != 2:
       print(f"usage: {sys.argv[0]} <version>")
       sys.exit(1)

    old_ver = get_current_version(".")
    new_ver = sys.argv[1]

    print(f"old version: {old_ver}")
    print(f"new version: {new_ver}")

    print("downloading binary release shasums...")
    shasums = get_shasums(new_ver)

    print("updating local files...")
    update_nats_server_env(old_ver, new_ver)
    update_nats_tag(old_ver, new_ver)

    update_nats_server_shasum_env(old_ver, new_ver, shasums)
    update_alpine_arch_shasums(old_ver, new_ver, shasums)

    print("renaming directory...")
    os.rename(old_ver, new_ver)

    print("update complete")

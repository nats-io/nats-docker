#!/usr/bin/env python3

import os
import re
import sys
import glob
import shutil
import typing
import urllib.request

semver_str = r"([0-9]+)\.([0-9]+)\.([0-9]+)(-(preview|rc)\.([0-9]+))?"
sha256_str = r"[A-Fa-f0-9]{64}"


# Update the NATS_SERVER env variable across applicable files.
def update_env_var(base_dir: str, new_ver: str):
    files = [
        f"./{base_dir}/windowsservercore-1809/Dockerfile",
        f"./{base_dir}/tests/build-images.sh",
        f"./{base_dir}/tests/run-images.sh",
        f"./{base_dir}/tests/build-images-2019.ps1",
        f"./{base_dir}/tests/run-images-2019.ps1",
    ] +  glob.glob(f"./{base_dir}/alpine*/Dockerfile")

    r = re.compile(r"(NATS_SERVER )" + semver_str)

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{new_ver}", data))


# Update the nats:x.y.z tag across applicable files.
def update_tag_var(base_dir: str, new_ver: str):
    files = [
        f"./{base_dir}/nanoserver-1809/Dockerfile",
        f"./{base_dir}/scratch/Dockerfile",
    ]

    r = re.compile(r"(--from=nats:)" + semver_str)

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{new_ver}", data))


# Update the nats:x.y.z tag across applicable files.
def update_preview_tag_var(base_dir: str, new_ver: str):
    files = [
        f"./{base_dir}/nanoserver-1809/Dockerfile.preview",
        f"./{base_dir}/scratch/Dockerfile.preview",
    ]

    r = re.compile(r"(BASE_IMAGE=nats:)" + semver_str)

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{new_ver}", data))


# Update the NATS SHASUM across applicable files.
def update_windows_shasums(base_dir: str, new_ver: str, shasums: typing.Dict):
    files = [
        f"{base_dir}/windowsservercore-1809/Dockerfile",
    ]

    key = f"nats-server-v{new_ver}-windows-amd64.zip"
    sha = shasums.get(key)

    r = re.compile(r"(NATS_SERVER_SHASUM )" + sha256_str)

    for f in files:
        with open(f, "r") as fd:
            data = fd.read()

        with open(f, "w") as fd:
            fd.write(r.sub(f"\g<1>{sha}", data))


def update_alpine_shasums(base_dir: str, new_ver: str, shasums: typing.Dict):
    file = glob.glob(f"{base_dir}/alpine*/Dockerfile")[0]

    with open(file, "r") as fd:
        data = fd.read()

    for arch in ["arm64", "arm6", "arm7", "amd64", "386", "s390x", "ppc64le"]:
        key = f"nats-server-v{new_ver}-linux-{arch}.tar.gz"
        arch_sha = shasums.get(key)
        r = re.compile(f"(natsArch='{arch}'; )"+r"sha256='" + sha256_str + r"'")
        data = r.sub(f"\g<1>sha256='{arch_sha}'", data)

    with open(file, "w") as fd:
        fd.write(data)


def get_shasums(ver: str) -> typing.Dict:
    u = f"https://github.com/nats-io/nats-server/releases/download/v{ver}/SHA256SUMS"

    d = {}
    try:
        with urllib.request.urlopen(u) as resp:
            data = resp.readlines()

        for line in data:
            sps = line.split()
            if len(sps) != 2:
                continue
            d[sps[1].decode("utf-8")] = sps[0].decode("utf-8")
    except Exception as e:
        pass

    return d


# Get the base version directory for the new version.
def get_base_version(cdir: str, maj_ver: int, min_ver: int) -> str:
    r = re.compile(r"[0-9]+\.[0-9]+\.x")

    base_dir = None
    for f in os.listdir(base_dir):
        if not r.search(f):
            continue

        toks = f.split(".")
        if len(toks) != 3:
            continue

        # Explicit match on major and minor.
        # First precedence.
        if int(toks[0]) == maj_ver and int(toks[1]) == min_ver:
            return f

        # Directory has prior minor version.
        # Second precedence.
        if int(toks[0]) == maj_ver and int(toks[1]) == (min_ver - 1):
            base_dir = f

        # Directory has prior major version.
        # Third precedence.
        if not base_dir and int(toks[0]) == (maj_ver - 1):
            base_dir = f

    return base_dir


def ensure_dir(base_dir: str, maj_ver: int, min_ver: int) -> str:
    # Already exists, use that minor directory.
    if os.path.exists(f"{maj_ver}.{min_ver}.x"):
        return f"{maj_ver}.{min_ver}.x"

    # Create and copy the directory.
    shutil.copytree(base_dir, f"{maj_ver}.{min_ver}.x", symlinks=True)

    return f"{maj_ver}.{min_ver}.x"


if __name__ == "__main__":
    if len(sys.argv) != 2:
       print(f"usage: {sys.argv[0]} <version>")
       sys.exit(1)

    new_ver = sys.argv[1]
    if not re.compile(semver_str).match(new_ver):
        print(f"invalid version: {new_ver}")
        sys.exit(1)

    toks = new_ver.split(".")
    maj_ver = int(toks[0])
    min_ver = int(toks[1])

    base_dir = get_base_version(".", maj_ver, min_ver)
    if not base_dir:
        print(f"unable to find base version for {maj_ver}.{min_ver}.x")
        sys.exit(1)

    print(f"base dir: {base_dir}")
    print(f"new version: {new_ver}")

    print("downloading binary release shasums...")
    shasums = get_shasums(new_ver)

    # Ensure the new directory exists.
    base_dir = ensure_dir(base_dir, maj_ver, min_ver)

    print("updating local files...")
    update_env_var(base_dir, new_ver)
    update_tag_var(base_dir, new_ver)
    update_preview_tag_var(base_dir, new_ver)

    update_windows_shasums(base_dir, new_ver, shasums)
    update_alpine_shasums(base_dir, new_ver, shasums)

    print("update complete")

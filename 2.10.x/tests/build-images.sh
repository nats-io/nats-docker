#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.10.19-RC.5)

(
	cd "../alpine3.20"
	docker build --tag nats:${ver[1]}-alpine3.20 .
)

(
	cd "../scratch"
	docker build --tag nats:${ver[1]}-scratch .
)

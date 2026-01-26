#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.12.4-RC.6)

(
	cd "../alpine3.22"
	docker build --tag nats:${ver[1]}-alpine3.22 .
)

(
	cd "../scratch"
	docker build --tag nats:${ver[1]}-scratch .
)

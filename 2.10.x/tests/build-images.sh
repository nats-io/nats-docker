#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.10.26-RC.2)

(
	cd "../alpine3.21"
	docker build --tag nats:${ver[1]}-alpine3.21 .
)

(
	cd "../scratch"
	docker build --tag nats:${ver[1]}-scratch .
)

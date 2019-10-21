#!/usr/bin/env bash
set -ex

(
	cd 2.1.0/alpine3.10
	docker build --tag nats:2.1.0-alpine3.10 .
)

(
	cd 2.1.0/scratch/amd64
	docker build --tag nats:2.1.0-scratch .
)

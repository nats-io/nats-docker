#!/usr/bin/env bash
set -ex

images=(
	'nats:2.9.20-alpine3.18'
	'nats:2.9.20-scratch'
)

for img in "${images[@]}"; do
	run_id=$(docker run --detach "${img}")
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done

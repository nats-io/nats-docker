#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.10.23-RC.8)

images=(
	"nats:${ver[1]}-alpine3.20"
	"nats:${ver[1]}-scratch"
)

for img in "${images[@]}"; do
	run_id=$(docker run --detach "${img}")
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done

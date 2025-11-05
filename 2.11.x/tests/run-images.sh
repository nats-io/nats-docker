#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.11.11-RC.2)

images=(
	"nats:${ver[1]}-alpine3.22"
	"nats:${ver[1]}-scratch"
)

for img in "${images[@]}"; do
	run_id=$(docker run --detach "${img}")
	sleep 1
	test -n "$(docker ps --filter "id=${run_id}" --filter "status=running" --quiet)"
	docker kill "$run_id"
done

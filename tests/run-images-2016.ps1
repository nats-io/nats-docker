# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$images = @(
	"nats:2.6.6-windowsservercore-ltsc2016"
)

foreach ($img in $images) {
	Write-Output "running ${img}"
	$runId = & docker run --detach "${img}"
	sleep 1

	Write-Output "checking ${img}"
	docker ps --filter "id=${runId}" --filter "status=running" --quiet
	if ($LASTEXITCODE -ne 0) {
		exit 1
	}
	docker kill $runId
}

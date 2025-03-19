# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

$ver = 'NATS_SERVER 2.11.0'.Split(' ')[1]

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

# The windowsservercore images must be built before the nanoserver images.
cd "../windowsservercore-1809"
Write-Host "building windowsservercore-1809"
docker build --tag "nats:${ver}-windowsservercore-1809" .
if ($LASTEXITCODE -ne 0) {
    exit 1
}

cd "../nanoserver-1809"
Write-Host "building nanoserver-1809"
docker build --tag "nats:${ver}-nanoserver-1809" .
if ($LASTEXITCODE -ne 0) {
    exit 1
}

docker images

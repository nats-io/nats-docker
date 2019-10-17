# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

cd 2.1.0/windowsservercoreltsc2016
Write-Host "building windowsservercore-ltsc2016"
docker build --tag nats:2.1.0-windowsservercore-ltsc2016 .

docker images

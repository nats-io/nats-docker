# Show statements as they run.
Set-PSDebug -Trace 2
# Exit on error.
$ErrorActionPreference = "Stop"

Write-Output '-- host info ---'
Write-Output $PSVersionTable
Write-Output (Get-WMIObject win32_operatingsystem).name
Write-Output (Get-WMIObject win32_operatingsystem).OSArchitecture

# The servercore images must be built before the nanoserver images.
cd 2.1.0/servercore1809
Write-Host "building servercore1809"
docker build --tag nats:2.1.0-servercore1809 .
cd ../nanoserver1809
Write-Host "building nanoserver1809"
docker build --tag nats:2.1.0-nanoserver1809 .

# We can't test these images on GitHub CI. We get the following error on both
# windows-2019 and windows-2016.
# 	The container operating system does not match the host operating system.
#
# cd ../servercore1803
# Write-Host "building servercore1803"
# docker build --tag nats:2.1.0-servercore1803 .
# cd ../nanoserver1803
# Write-Host "building nanoserver1803"
# docker build --tag nats:2.1.0-nanoserver1803 .

docker images

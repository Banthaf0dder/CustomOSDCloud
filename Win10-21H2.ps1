Write-Host  -ForegroundColor Yellow "Starting Custom OSDCloud..."
cls

Write-Host  -ForegroundColor Yellow "Loading OSDCloud..."

Import-Module OSD -Force
Install-Module OSD -Force

Start-OSDCloud -OSLanguage en-us -OSBuild 21H1 -OSEdition Enterprise -ZTI

wpeutil reboot
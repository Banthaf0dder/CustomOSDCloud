Import-Module DellBIOSProvider -Force

Set-Item -Path "DellSmbios:\SystemConfiguration\EmbSataRaid" -Value "Ahci"

$ServiceTag = (Get-Item -Path "DellSmbios:\SystemInformation\SvcTag").CurrentValue

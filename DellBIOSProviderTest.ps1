Import-Module DellBIOSProvider -Force

Set-Item -Path "DellSmbios:\SystemConfiguration\EmbSataRaid" -Value "Ahci"

$ServiceTag = (Get-Item -Path "DellSmbios:\SystemInformation\SvcTag").CurrentValue
$IP = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$BootBody = @"
{
    "type": "message",
    "attachments": [
        {
            "contentType": "application/vnd.microsoft.card.adaptive",
            "content": {
                "type": "AdaptiveCard",
                "body": [
                    {
                        "type": "TextBlock",
                        "size": "Medium",
                        "weight": "Bolder",
                        "text": "OSDCloud Image Boot - Test",
                        "style": "heading",
                        "wrap": true
                    },
                    {
                        "type": "ColumnSet",
                        "columns": [
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "Image",
                                        "style": "Person",
                                        "url": "https://i.imgur.com/1TBzViu.png",
                                        "altText": "Intel EMA",
                                        "size": "Small"
                                    }
                                ],
                                "width": "auto"
                            },
                            {
                                "type": "Column",
                                "items": [
                                    {
                                        "type": "TextBlock",
                                        "weight": "Bolder",
                                        "text": "Intel EMA - Booted",
                                        "wrap": true
                                    },
                                    {
                                        "type": "TextBlock",
                                        "spacing": "None",
                                        "text": "SN: $ServiceTag",
                                        "isSubtle": true,
                                        "wrap": true
                                    }
                                ],
                                "width": "stretch"
                            }
                        ]
                    },
                    {
                        "type": "TextBlock",
                        "text": "Test DCB $ServiceTag has booted from an OSDCloud ISO in Intel EMA with IP $IP.",
                        "wrap": true
                    }
                ],
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.5"
            }
        }
    ]
}
"@
$uri = 'https://loves.webhook.office.com/webhookb2/37ac53cf-01a8-454e-ad2a-47103c06526b@80132c19-eaaa-4b91-acf7-a3ed9a50c97b/IncomingWebhook/9d5e75c6216942bcae05629f1695c04e/870b41a1-4119-4392-b874-8d2adb82fc0f'
$BootHeaders = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$BootHeaders.Add("Content-Type", "text/plain")
Invoke-RestMethod -Uri $uri -Body $BootBody -Headers $BootHeaders -Method POST

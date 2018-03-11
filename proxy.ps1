cls
$reg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$settings = Get-ItemProperty -Path $reg
Write-Host "Proxy:" $settings.ProxyServer
Write-Host "Activado?:" $settings.ProxyEnable

#Set-ItemProperty -Path $reg -Name ProxyEnable -Value 0
#Set-ItemProperty -Path $reg -Name ProxyServer -Value "127.0.0.1:8082"
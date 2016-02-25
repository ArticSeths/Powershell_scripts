cls
Write-Host "---------------------MI RED--------------------"
$int1 = 0
netsh wlan show interface | Select-String Nombre,SSID,BSSID,Se¤al | % {
[string]$val = $_
if ($int1 -eq 0){
write-host "Nombre:   "$val.substring(28)
}elseif ($int1 -eq 1){
write-host "SSID:     "$val.substring(28)
}elseif ($int1 -eq 2){
write-host "BSSID:    "$val.substring(28)
}elseif ($int1 -eq 3){
write-host "Señal:    "$val.substring(37)
}
$int1 = $int1 +1
}
netsh wlan show profile name=$SSID key=clear | Select-String 'Contenido de la clave' | % {
[string]$val = $_
write-host "Clave:    "$val.substring(28)
}
Write-Host "-----------------------------------------------`n"

Write-Host "----------------MIS ADAPTADORES----------------"
Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | Format-List -Property Name,NetConnectionID,Speed,MACAddress
Write-Host "-----------------------------------------------"

Write-Host "------------------MIS VECINOS------------------"
$fichero=gc C:\power\oui.txt
$int = 0
netsh wlan show networks mode=bssid | Select-String Nombre,SSID,BSSID,'Tipo de radio',Se¤al | % {
[string]$val = $_
if ($int -eq 1){
write-host "Nombre:   "$val.substring(9)
}elseif($int -eq 2){
write-host "Mac:      "$val.substring(26)
foreach($mac in $val.substring(26))
{
[string]$m = $fichero | Select-String ($mac.Substring(0,8).replace(':','')).ToUpper()
if ($m -notlike ""){write-host "Compañia: "$m.substring(22)}
}
}elseif($int -eq 3){
write-host "Señal:    "$val.substring(30)
}elseif($int -eq 4){
write-host "Tipo:     "$val.substring(30)
Write-Host "-------"
$int = 0
}
$int = $int +1
}
Write-Host "-----------------------------------------------"
Write-Host "------------------Trabajo WiFi-----------------"
Write-Host "--------------Por: Diego Alfayate--------------"
Write-Host "-----------------------------------------------"
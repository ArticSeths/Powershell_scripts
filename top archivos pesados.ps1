cls
$i = 0
foreach($pro in ls | Sort-Object length -Descending | Select-Object -first 5){
$i++
if ($i -eq 1){
$color = "yellow"
}
if ($i -eq 2){
$color = "gray"
}
if($i -eq 3){
$color = "Red"
}
if ($i -gt 3){
$color = "white"
}
Write-Host "--------------------" $i "--------------------" -ForegroundColor $color
if ($pro.Length -gt 1024){
#kb
[string]$tm = $pro.Length / 1024
$tm=$tm.Split(".")[0] + "." + $tm.Split(".")[1].Substring(0,2)
$fi = "KB"
}
if ($pro.Length -gt 1048576){
#mb
[string]$tm = $pro.Length / 1048576
$tm=$tm.Split(".")[0] + "." + $tm.Split(".")[1].Substring(0,2)
$fi = "MB"
}
write-host "* Nombre del archivo: " $pro.name -ForegroundColor $color
write-host "* Tamaño del archivo: " $tm $fi -ForegroundColor $color
Write-Host "-------------------------------------------" -ForegroundColor $color
write-host ""
sleep -s 1
}
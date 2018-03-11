while(1 -ne 0){
cls
$q = gc "C:\Users\user\Documents\power\comands.txt"
$q | % {
$result=(Invoke-WebRequest -Uri $_)
$conv=$result.Content
$convi = $conv | ConvertFrom-JSON
$ciudad = $convi.query.results.channel.location.city
$temp = $convi.query.results.channel.item.condition.temp
Write-Host "La temperatura en " -NoNewline
Write-Host $ciudad -NoNewline
Write-Host " es de " -NoNewline
Write-Host $temp
}
sleep -s 5
}
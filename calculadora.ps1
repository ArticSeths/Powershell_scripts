cls
Write-Host "---------------------------------------"
write-host "          HOLA, Bienvenido!            "
Write-Host "---------------------------------------"
 sleep -s 0.2
[int]$val1 = read-host "Primer valor"
[int]$val2 = read-host "Segundo valor"
write-host "---------------------------------------"
write-host "1) Suma"
write-host "2) Resta"
write-host "3) División"
write-host "4) Multiplicación"
$op = read-host "Elige acción"
if ($op -like 1){
$result = $val1+$val2
}
if ($op -like 2){
$result = $val1-$val2
}
if ($op -like 3){
$result = $val1/$val2
}
if ($op -like 4){
$result = $val1*$val2
}
write-host "---------------------------------------"
Write-host "El resultado es:"$result
write-host "---------------------------------------"
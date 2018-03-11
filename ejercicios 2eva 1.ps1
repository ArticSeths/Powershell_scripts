#Ejercicio 1
(ps).modules
#Ejercicio 2
Start-Process notepad.exe
(ps -name "notepad").modules | sort size -Descending
#Ejercicio 3
$r = Read-Host "Nombre del proceso"
Stop-Process -name $r
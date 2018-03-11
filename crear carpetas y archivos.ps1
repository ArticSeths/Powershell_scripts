cls
$ubi = read-host "Ubicación de las carpetas:"

$dir1 = read-host "Nombre carpeta 1:"
$archi11 = read-host "Nombre del archivo 1 carpeta 1:"
$Carchi11 = read-host "Contenido del archivo 1 carpeta 1:"
$Tarchi11 = read-host "Tipo del archivo 1 carpeta 1:"
$archi12 = read-host "Nombre del archivo 2 carpeta 1:"
$Carchi12 = read-host "Contenido del archivo 2 carpeta 1:"
$Tarchi12 = read-host "Tipo del archivo 2 carpeta 1:"

$dir2 = read-host "Nombre carpeta 2:"
$archi21 = read-host "Nombre del archivo 1 carpeta 2:"
$Carchi21 = read-host "Contenido del archivo 1 carpeta 2:"
$Tarchi21 = read-host "Tipo del archivo 1 carpeta 2:"
$archi22 = read-host "Nombre del archivo 2 carpeta 2:"
$Carchi22 = read-host "Contenido del archivo 2 carpeta 2:"
$Tarchi22 = read-host "Tipo del archivo 2 carpeta 2:"

cd $ubi
new-item -ItemType directory -name $dir1
$ubi1 = [string]$ubi + "\" + [string]$dir1
cd $ubi1
New-Item -name ($archi11+"."+$Tarchi11) -ItemType file -value $Carchi11
New-Item -name ($archi12+"."+$Tarchi12) -ItemType file -value $Carchi12

cd $ubi
new-item -ItemType directory -name $dir2
$ubi2 = [string]$ubi + "\" + [string]$dir2
cd $ubi2
New-Item -name ($archi21+"."+$Tarchi21) -ItemType file -value $Carchi21
New-Item -name ($archi22+"."+$Tarchi22) -ItemType file -value $Carchi22
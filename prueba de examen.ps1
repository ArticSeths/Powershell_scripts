#Tipos de paquetes en linux: deb, rpm, tgz
#Diferencia entre servicio y tarea programada:
# *Una tarea programada es un proceso logico que se ejecuta a un tiempo determinado sin necesidad de tener a un usuario delante
# *Un servicio es una tarea que te torga cierta información
#---------------------------
#PowerShell Carpetas
New-Item -ItemType Directory -name nombre -Path ./
#Linux Carpetas
mkdir carpeta
#---------------------------
# Vuelve a la raiz
cd /
# Carpeta actual
cd .
# Carpeta anterior
#---------------------------
#Buscar archivos en PowerShell
ls ./ -Recurse ol.txt
#Buscar archivos en Linux
find ./ -name ol.txt
#---------------------------
#Buscar archivos en PowerShell modificado en los ultimos 30 dias
ls ./ -Recurse | where LastWriteTime -lt (date).AddMinutes(-30)
#Buscar archivos en Linux modificado en los ultimos 30 dias
find ./ -mmin -30
#---------------------------
# Alias de: Get-ChildItem
ls
# Alias de: Get-process
ps
gps
# Alias de: Set-Location
cd
#---------------------------
$kb=Read-Host "Numero de actualización"
((Get-HotFix).hotfixid | Select-String $kb)
# Pide al usuario el numero de actualización y te lo muestra
#---------------------------
(Get-HotFix).description | Group-Object
# Agrupar las actualizaciones por descripción
#---------------------------
((Get-WmiObject -Class win32_product).name).count
# Número de programas instalados
#---------------------------
if ((Get-WmiObject -Class win32_product).name | Select-String "Gimp"){"Instalado"}
# Dice si esta instalado o no Gimp
#---------------------------
Get-Process -module
# Muestra las dlls
#---------------------------
Get-Process -name (Read-Host 'n') -module
# Pide el nombre de la dll y lo muestra
#---------------------------
Get-Process | Select-Object ProcessName | Select-String "svchost"
# Muestra el nombre del proceso
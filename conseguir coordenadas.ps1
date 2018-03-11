#-----------------------------------------------------#
#---------------Configuración de script---------------#
#-----------------------------------------------------#
$ubi = 'C:\users\user\Desktop\new\coordenadas.txt'
#-----------------------------------------------------#
#---------------Fin de la configuración---------------#
#-----------------------------------------------------#
$co = [System.Windows.Forms.Cursor]::Position
$cox = $co.x
$coy = $co.y
while(1 -ne 0){
$tmil = $tmil +10
start-sleep -milliseconds 1
$co = [System.Windows.Forms.Cursor]::Position
if ($cox -like $co.x -or $coy -like $co.y) {

}else{
$co = [System.Windows.Forms.Cursor]::Position
$codata = 'mover,' + [string]$co.x + ','+ [string]$co.y + "`n"
$codata | Out-File -FilePath $ubi -Append
$codata = 'esperar,' + $tmil + "`n"
$codata | Out-File -FilePath $ubi -Append
$tmil = 0
$cox = $co.x
$coy = $co.y
cls
write-host $codata
}
}

#------------------------------------------------------#
#------------------ Creado por: Seths -----------------#
#------------------------------------------------------#

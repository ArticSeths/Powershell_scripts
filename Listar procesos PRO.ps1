#-----------------------------------------------------#
#---------------Configuración de script---------------#
#-----------------------------------------------------#
$ubi = "C:\Users\user\Documents\logs" #ubicación de logs
$t = 60 #tiempo de espera en cada backup (minimo 60)
#-----------------------------------------------------#
#---------------Fin de la configuración---------------#
#-----------------------------------------------------#
$nb = 0
while(1 -ne 0){
$fech = Get-Date -format "ddMMyyyyHHmm"
cd $ubi
New-Item -path $ubi -ItemType directory -Name $fech
$nfech = $ubi + "\" + $fech
cd $nfech
$n = 0
ps | %{
$name = [string]$n+ "-" + $_.name + ".txt"
$n = $n+1
New-Item -path ./ -name $name -ItemType file

$Handles = "Handles: " + $_.handles + "`n"
$Handles | Out-File -FilePath ($nfech + "\" + $name) -Append

$npm = "NPM(K): " + $_.NPM + "`n"
$npm | Out-File -FilePath ($nfech + "\" + $name) -Append

$pm = "PM(K): " + $_.PM + "`n"
$pm | Out-File -FilePath ($nfech + "\" + $name) -Append

$ws = "WS(K): " + $_.WS + "`n"
$ws | Out-File -FilePath ($nfech + "\" + $name) -Append

$vm = "VM(M): " + $_.VM + "`n"
$vm | Out-File -FilePath ($nfech + "\" + $name) -Append

$cpu = "CPU(s): " + $_.CPU + "`n"
$cpu | Out-File -FilePath ($nfech + "\" + $name) -Append

$id = "Id: " + $_.Id + "`n"
$id | Out-File -FilePath ($nfech + "\" + $name) -Append
}
cls
$date = Get-Date -format "dd-MM-yyyy HH:mm"
$nb = $nb+1
write-host ("Último backup: " + $date + "`n" + "Backups realizados: " + $nb)
sleep -s $t
}
#------------------------------------------------------#
#------------------ Creado por: Seths -----------------#
#------------------------------------------------------#

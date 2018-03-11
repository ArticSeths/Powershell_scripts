#-----------------------------------------------------#
#---------------Configuración de script---------------#
#-----------------------------------------------------#
$proc = 'VIRUS'   #Nombre del proceso
$sec = 1           #Segundos en cada loop
$Kill = 'Si'       #Escribe 'Si' para matar el proceso
#-----------------------------------------------------#
#---------------Fin de la configuración---------------#
#-----------------------------------------------------#
$i = 1
While ($i -ne 0) {
cls
[void] (ps $proc -EA SilentlyContinue)

    if ($Error -notlike “Compruebe el nombre del proceso y ejecute de nuevo el cmdlet” ) {
        $Error.clear()
        write-host " "
        write-host "* El proceso '$proc' no esta abierto."
    }else{
        $Error.clear()
        if ($Kill -like "Si"){
             $msg = "y se a cerrado"
             Stop-Process -Name $proc -Force
        }else{
        }
        write-host " "
        write-host "El proceso '$proc' está abierto" $msg -EA SilentlyContinue "."
        Clear-Variable -Name msg
    }
    Start-Sleep -S $sec
}

#------------------------------------------------------#
#------------------ Creado por: Seths -----------------#
#------------------------------------------------------#

cls
$ubiDA = "C:\Users\user\Documents\AdminArchi\data\conf.txt"
$ubiAR = "C:\Users\user\Documents\AdminArchi\archivos"

function crear{
cls
    Write-Host " ------------------------------------------------------------------"
    Write-Host "|      _ _                        _  __                            |
|     | (_)                      | |/ _|                           |
|   __| |_  ___  __ _  ___   __ _| | |_ __ _   ___ ___  _ __ ___   |
|  / _  | |/ _ \/ _  |/ _ \ / _  | |  _/ _  | / __/ _ \| '_   _ \  |
| | (_| | |  __/ (_| | (_) | (_| | | || (_| || (_| (_) | | | | | | |
|  \__,_|_|\___|\__, |\___/ \__,_|_|_| \__,_(_)___\___/|_| |_| |_| |
|                __/ |                                             |
|               |___/                                              |"
    Write-Host " ------------------------------------------------------------------"
    Write-Host " ----------------- Executator - By Diego Alfayate -----------------"
    Write-Host " ------------------------------------------------------------------"
    $ubiA = Read-Host "  Ubicación del archivo"
    Write-Host " -------------------- Archivos de la ubicación --------------------"
    Get-ChildItem $ubiA | %{
    write-host " *" $_.name
    }
    Write-Host " ------------------------------------------------------------------"
    $nameA = Read-Host "  Nombre del archivo"

    [string]$count = ((Get-ChildItem $ubiAR).Count) + 1;
    [string]$ubiAT = $count + "*" + ($ubiAR + "\" + $nameA) + "*" + $nameA
    $ubiAT | Out-File -FilePath $ubiDA -Append
    Copy-Item -Path ($ubiA + "\" + $nameA) -Destination $ubiAR
    Write-Host " ------------------------------------------------------------------"
    Write-Host "  Finalizado!"
    sleep -s 1
    menu
}

function ver{
cls
Write-Host " ------------------------------------------------------------------"
    Write-Host "|      _ _                        _  __                            |
|     | (_)                      | |/ _|                           |
|   __| |_  ___  __ _  ___   __ _| | |_ __ _   ___ ___  _ __ ___   |
|  / _  | |/ _ \/ _  |/ _ \ / _  | |  _/ _  | / __/ _ \| '_   _ \  |
| | (_| | |  __/ (_| | (_) | (_| | | || (_| || (_| (_) | | | | | | |
|  \__,_|_|\___|\__, |\___/ \__,_|_|_| \__,_(_)___\___/|_| |_| |_| |
|                __/ |                                             |
|               |___/                                              |"
Get-Content $ubiDA | % {
    $id=$_.split(‘*’)[0]
    $VubiAR=$_.split(‘*’)[1]
    $VnameAR=$_.split(‘*’)[2]
    Write-Host " ------------------------------------------------------------------"
    Write-Host " - ID:"$id
    Write-Host " - NOMBRE:"$VnameAR
    Write-Host " - Para más info escribe: "$id
}
Write-Host " ------------------------------------------------------------------"
write-host " 0. Ir al menu"
Write-Host " ------------------------------------------------------------------"
$cc = Read-Host "Elige opción"
if ($cc -like "0"){
menu
}
cls
Get-Content $ubiDA | % {
    $op=$_.split(‘*’)[0]
    $VubiAR=$_.split(‘*’)[1]
    $VnameAR=$_.split(‘*’)[2]
    if ($cc -like $op){
        Write-Host " ------------------------------------------------------------------"
        Write-Host " ---------------------------- Contenido ---------------------------"
        Write-Host " ------------------------------------------------------------------"
        Get-Content $VubiAR | %{
        Write-Host ($_) -BackgroundColor white -ForegroundColor black
        }
        Write-Host " ------------------------------------------------------------------"
        Write-Host "1. Ejecutar"
        Write-Host "2. Atrás"
        $c = Read-Host "Elige opción"
        if ($c -like "1"){
        cls
        & $VubiAR
        }
        if ($c -like "2"){
        ver
        }
    }
}
}

function menu{
cls
    Write-Host " ------------------------------------------------------------------"
    Write-Host "|      _ _                        _  __                            |
|     | (_)                      | |/ _|                           |
|   __| |_  ___  __ _  ___   __ _| | |_ __ _   ___ ___  _ __ ___   |
|  / _  | |/ _ \/ _  |/ _ \ / _  | |  _/ _  | / __/ _ \| '_   _ \  |
| | (_| | |  __/ (_| | (_) | (_| | | || (_| || (_| (_) | | | | | | |
|  \__,_|_|\___|\__, |\___/ \__,_|_|_| \__,_(_)___\___/|_| |_| |_| |
|                __/ |                                             |
|               |___/                                              |"
    Write-Host " ------------------------------------------------------------------"
    Write-Host " ----------------- Executator - By Diego Alfayate -----------------"
    Write-Host " ------------------------------------------------------------------"
    write-host "  1. Añadir archivo"
    Write-Host "  2. Ver lista"
    Write-Host "  3. salir"
    Write-Host " ------------------------------------------------------------------"
    $c = Read-Host "  * Elige opción"

    if( $c -like "1"){
    crear
    }

    if($c -like "2"){
    ver
    }

}
menu
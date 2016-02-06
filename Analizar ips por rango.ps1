cls
Write-Host "Buscando librerías ..."

if (Test-Path -Path $home/analizer){
    Write-Host "Carpeta 'analizer' existe"
    sleep -s 1
}else{
    Write-Host "Carpeta 'analizer' no existe"
    Write-Host "Creando carpeta ..."
    New-Item -path "$home" -Name analizer -ItemType directory | Out-Null
    Write-Host "Carpeta creada correctamente"
    sleep -s 1
}

if (Test-Path -Path $home/analizer/ouilist.txt){
    Write-Host "Librería 'ouilist' existe"
    sleep -s 1
}else{
    Write-Host "Librería 'ouilist' no existe"
    Write-Host "Descargando librería ..."
    $url = 'http://standards.ieee.org/develop/regauth/oui/oui.txt'
    $outfile = "$home/analizer/ouilist.txt"
    Invoke-WebRequest -Uri $url -OutFile $outfile
    Write-Host "Librería descargada correctamente"
    sleep -s 1
}
if (Test-Path -Path $home/analizer/log_ips.txt){
    Write-Host "Librería 'log_ips' existe"
    sleep -s 1
}else{
    Write-Host "Librería 'log_ips' no existe"
    Write-Host "Creando librería ..."
    New-Item -path "$home/analizer" -Name log_ips.txt -ItemType file | Out-Null
    Write-Host "Librería creada correctamente"
    sleep -s 1
}
Write-Host "Cargando script ..."
sleep -s 2
cls
$nic = gwmi -computer . -class "win32_networkadapterconfiguration" | Where-Object {$_.defaultIPGateway -ne $null}
$IP = $nic.ipaddress | select-object -first 1
$ClientMask = $nic.ipsubnet | select-object -first 1
$IP.Split('.')[0]
if ($ClientMask.Split('.')[0] -like 255){
    $Ip1 = $IP.Split('.')[0] + "."
}else{
    $Ip1 = ""
}
if ($ClientMask.Split('.')[1] -like 255){
    $Ip2 = $IP.Split('.')[1] + "."
}else{
    $Ip2 = ""
}
if ($ClientMask.Split('.')[2] -like 255){
    $Ip3 = $IP.Split('.')[2] + "."
}else{
    $Ip3 = ""
}
if ($ClientMask.Split('.')[3] -like 255){
    $Ip4 = $IP.Split('.')[3]
}else{
    $Ip4 = ""
}
$RedFull = $Ip1+$Ip2+$Ip3+$Ip4
$ValMin = 0
$ValMax = 20
$ubi = "$home\analizer\log_ips.txt"
cls
function config {
    cls
    write-host "#----------------Configuración----------------#"
    [Int]$ValMin = read-host "Rango ips - Valor mínimo"
    [Int]$ValMax = read-host "Rango ips - Valor máximo"
    write-host "#-----------Configuración terminada-----------#"
    sleep -s 1
    cls
    menu
}
function info{
    cls
    write-host "#-----------------Información-----------------#"
    write-host ("El rango de ips es de " + $ValMin + " a " + $ValMax)
    write-host ("El nombre de tu red es: " + $RedFull)
    write-host ("Ubicación del registro: " + $ubi)
    write-host "#---------------------------------------------#`n"
    [String]$Volv = read-host "Volver? [S] o [N]"
    if ($Volv -like "s" -or "S"){
    menu
    }
}

function analizar{
    cls
    $new = ""
    $new | Out-File -FilePath $ubi
    $ValSum = $ValMin
    while($ValSum -lt $ValMax+1){
    cls
    [string]$PercA = (($ValSum/$ValMax)*100)
    
    write-host "#----------------Buscando ips-----------------#"
    write-host ("Rango: "+$ValSum+" --- "+$PercA.Split("{,}")+"%")
    write-host "#---------------Ips encontradas---------------#"
    write-host $ips
    $ipcon = [string]$RedFull+[string]$ValSum
        $test = Test-Connection -ComputerName $ipcon -Count 1 -Quiet
        if ($test -like "True"){
            $ips = $ips + "* "+$ipcon + "`n"
            $ipsave = 'ip,' + $ipcon + "`n"
            $ipsave | Out-File -FilePath $ubi -Append
        }
        $ValSum = $ValSum+1
    }
    write-host "#-------------Fin de la busqueda--------------#`n"
    [String]$Volv = read-host "Volver? [S] o [N]"
    if ($Volv -like "s" -or "S"){
    menu
    }
}

function equipos {
    cls
    write-host "#----------Lista de equipos en red-----------#"
    $outfile = "$home\analizer\ouilist.txt"
    foreach($ips in Get-Content $ubi){
        $IpSlpit=$ips.split(‘,’)[1]
        foreach($net in Get-NetNeighbor){
            if ($net.ipaddress -like $IpSlpit){
                write-host "-----------------------------------"
                write-host "Estado:" $net.state
                write-host "Versión de IP:" $net.AddressFamily
                write-host "Index:" $net.ifindex
                write-host "Nombre:" $net.name
                write-host "Interface:" $net.InterfaceAlias
                write-host "Ip:" $net.ipaddress
                write-host "Mac:" $net.linkLayerAddress
                if ($net.linkLayerAddress -like ""){

                }else{
                    $mac = $net.linkLayerAddress
                    $spliter = $mac.substring(0,8)
                    if($spliter -like "00-00-00"){
            
                    }else{
                        if($spliter -like "ff-ff-ff"){
                
                        }else{
                           [string]$content = Get-Content -Path $outfile | Select-String $spliter
                           write-host "Info:" $content.substring(18)
                        }
                    }
                }
                write-host "-----------------------------------"
            }
        }
    }

    write-host "#--------------------------------------------#"
    [String]$Volv = read-host "Volver? [S] o [N]"
    if ($Volv -like "s" -or "S"){
    menu
    }
}

function menu {
cls
    [int]$Menu = 0
    write-host "#-----------Script Equipos en red------------#"
    Write-host "[1] Analizar equipos conectados a la red"
    Write-host "[2] Ver información de los equipos analizados"
    Write-host "[3] Información"
    Write-host "[4] Configuración"
    Write-host "[5] Salir"
    write-host "#------------Por: Diego Alfayate-------------#`n"
    [Int]$Menu = read-host "Elija su opción"
    Switch($Menu){
    
      1{analizar}
      2{equipos}
      3{info}
      4{config}
      5{cls}
    }
}
menu

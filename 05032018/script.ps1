# Para crear credenciales: read-host -AsSecureString | ConvertFrom-SecureString
# El resultado meterlo en archivo cred:
#  - [IP] [USUARIO] [CREDENCIAL]


# Estructura para lista.txt:
#  - [ACTION (ADD / REMOVE / INSTALL / UNINSTALL)] [USER / PACKAGE] [USAURIO:GRUPO / NOMBRE-PAQUETE] [IP-HOST / THISPC]

# EJEMPLO: add user user:grupo thispc
# EJEMPLO: install package p7zip 90.74.230.66

gc ./lista.txt | % {
    $action = $_.split(' ')[0]
    $actType = $_.split(' ')[1]
    $name = $_.split(' ')[2]
    $hostp = $_.split(' ')[3]

    if($actType -eq 'user'){
        if($hostp -eq 'thispc'){
            if($action -eq 'add'){
                if(get-LocalUser | where name -eq $name.split(':')[0]){
                    'El usuario '+$name.split(':')[0]+' ya existe en esta PC. '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                }else{
                    New-LocalUser -Name $_ -Password (ConvertTo-SecureString -String $passDef)
                    'El usuario '+$name.split(':')[0]+' ha sido creado correctamente en esta PC. '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                }
            }elseif($action -eq 'remove'){
                if(get-LocalUser | where name -eq $name.split(':')[0]){
                    Remove-LocalUser -Name $name.split(':')[0]
                    'El usuario '+$name.split(':')[0]+' ha sido borrado correctamente de esta PC. '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                }else{
                    'El usuario '+$name.split(':')[0]+' no existe en esta PC. '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                }
            }
        }else{
            gc .\cred | % {
                if($_.split(' ')[0] -eq $hostp){
                    $user = $_.split(' ')[1]
                    $pass = $_.split(' ')[2] | ConvertTo-SecureString
                    $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $user,$pass

                    New-SSHSession -ComputerName $hostp -Credential $credentials
                    if($action -eq 'add'){
                        (Invoke-SSHCommand -Index 0 -Command 'sudo adduser '+$name).Output
                        'El usuario '+$name+' ha sido creado en la maquina '+$hostp+' a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                    }elseif($action -eq 'remove'){
                        (Invoke-SSHCommand -Index 0 -Command 'sudo userdel '+$name).Output
                        'El usuario '+$name+' ha sido eliminado de la maquina '+$hostp+' a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                    }

                    Remove-SSHSession -SessionId 0
                }
            }
        }

    }elseif($actType -eq 'package'){
        if($hostp -eq 'thispc'){
            if($action -eq 'install'){
                Install-Package -name $name
                'El paquete '+$name+' ha sido instalado en esta PC a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
            }elseif($action -eq 'uninstall'){
                Uninstall-Package -name $name
                'El paquete '+$name+' ha sido desinstalado en esta PC a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
            }
        }else{
            gc .\cred | % {
                if($_.split(' ')[0] -eq $hostp){
                    $user = $_.split(' ')[1]
                    echo $_.split(' ')[2]
                    $pass = $_.split(' ')[2] | ConvertTo-SecureString
                    $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $user,$pass

                    New-SSHSession -ComputerName $hostp -Credential $credentials
                    if($action -eq 'install'){
                        (Invoke-SSHCommand -Index 0 -Command 'apt-get install '+$name+' -y').Output
                        'El paquete '+$name+' ha sido instalado en la maquina '+$hostp+' a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                    }elseif($action -eq 'uninstall'){
                        (Invoke-SSHCommand -Index 0 -Command 'apt-get remove '+$name+' -y').Output
                        'El paquete '+$name+' ha sido desinstalado en la maquina '+$hostp+' a las '+(get-date -Format 'yyyy-MM-dd hh:mm:ss') >> $PSScriptRoot\logs.log
                    }

                    Remove-SSHSession -SessionId 0
                }
            }
        }
    }
}

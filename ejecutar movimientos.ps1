#-----------------------------------------------------#
#---------------Configuración de script---------------#
#-----------------------------------------------------#
$ubi = $home+'\Desktop\new\coordenadas.txt'
#-----------------------------------------------------#
#---------------Fin de la configuración---------------#
#-----------------------------------------------------#
Get-Content $ubi | %{
    write-host $_
    $operacion=$_.split(‘,’)[0]
    $param1=$_.split(‘,’)[1]
    $param2=$_.split(‘,’)[2]
    switch($operacion){
        ‘esperar'{
        Start-Sleep -Milliseconds $param1
        break
        }
        ‘mover'{
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($param1,$param2)
        Start-Sleep -Milliseconds 1
        break
        }
        ‘click'{
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($param1,$param2)
            $MouseEventSig=@’
    [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
‘@
    $MouseEvent = Add-Type -memberDefinition $MouseEventSig -name “MouseEventWinApi” -passTh
    $MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
    $MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
        break
        }
    }
}

#------------------------------------------------------#
#------------------ Creado por:Seths ------------------#
#------------------------------------------------------#

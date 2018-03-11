
#--------------CONFIGURACIÓN--------------#
#Palabras a buscar (Separalas por comas):
$P = 'Luis, como cambiar de pantalla, Tengo hambre'
#URL donde buscar (Ej: google.com):
$URL = 'http://google.com/'
#Explorador a usar (Ej: Chrome):
$EX = 'Chrome'
#-------------------FIN-------------------#

cls
$MouseEventSig=@’
[DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
‘@
$MouseEvent = Add-Type -memberDefinition $MouseEventSig -name “MouseEventWinApi” -passThru
Start-Process $EX $URL
sleep -s 6
While (1 -ne 0) {
$rand_p = Get-Random -InputObject $p.Split(“,”) -Count 1
[System.Windows.Forms.SendKeys]::SendWait($rand_p)
$time = Get-Random -Maximum 4 -Minimum 1
sleep -s $time
[System.Windows.Forms.SendKeys]::SendWait(“{ENTER}”)
sleep -s $time
$rnd_w = Get-Random -Maximum 75 -Minimum 69
$rnd_h = Get-Random -Maximum 111 -Minimum 105
[Windows.Forms.Cursor]::Position = "$($rnd_w),$($rnd_h)"
sleep -s $time
$MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
$MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
sleep -s $time

}

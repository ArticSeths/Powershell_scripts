
#--------------CONFIGURACIÓN--------------#
#Palabras a buscar (Separalas por comas):
$P = 'transparent'
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

#Abrir por ejemplo google.es y realizar una búsqueda

[Reflection.Assembly]::LoadWithPartialName(“System.Drawing”)
function screenshot([Drawing.Rectangle]$bounds, $path)
{
$bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
$graphics = [Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
$bmp.Save($path)
$graphics.Dispose()
$bmp.Dispose()
}
#Cadena a buscar dentro de la captura
#                                       armando
$cadena=’Transparent en Movistar Series’

for($i=260; $i -ge 760; $i+=120)
{
$i
$bounds = [Drawing.Rectangle]::FromLTRB(120, $i, 680, $i+100)
$fichero=’C:\Users\user\Documents\power\captura’+$i+’.png’
screenshot $bounds $fichero
cd ‘C:\Program Files (x86)\Tesseract-OCR’
$ficheroout=’C:\Users\user\Documents\power\captura’+$i
.\tesseract.exe $fichero $ficheroout -l spa

$ficherocontxt=$ficheroout+’.txt’
$contenido=Get-Content $ficherocontxt -Encoding UTF8
$contenido
if($contenido -match $cadena)
{
$i+20 | Out-File C:\Users\user\Documents\power\posiciones.txt -Append
}
}
$MouseEventSig=@’
[DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
‘@

$MouseEvent = Add-Type -memberDefinition $MouseEventSig -name “MouseEventWinApi” -passThru
#Pulsar en resultados positivos

Get-Content C:\Users\user\Documents\power\posiciones.txt | %{
Start-Sleep -Seconds 2
$param1=155
$param2=$_
$param1
$param2
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($param1,$param2)
$MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
$MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
}


[Windows.Forms.Cursor]::Position = "$(145),$(60)"
sleep -s $time
$MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
$MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
sleep -s $time

}
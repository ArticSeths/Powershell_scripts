sleep -s 5
while(1 -ne 0){
[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
function screenshot([Drawing.Rectangle]$bounds, $path)
{
$bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
$graphics = [Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
$bmp.Save($path)
$graphics.Dispose()
$bmp.Dispose()
}

$bounds = [Drawing.Rectangle]::FromLTRB(15, 211, 1170, 248)
$fichero='C:\Users\ArticDirex\Documents\power\cap.png'
screenshot $bounds $fichero
cd ‘C:\Program Files (x86)\Tesseract-OCR’
$ficheroout=’C:\Users\ArticDirex\Documents\power\cap’
.\tesseract.exe $fichero $ficheroout -l spa

$ficherocontxt=$ficheroout+’.txt’
$contenido=Get-Content $ficherocontxt -Encoding UTF8
[System.Windows.Forms.SendKeys]::SendWait($contenido)
write $contenido
}
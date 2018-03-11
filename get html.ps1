$valo = Read-Host "valor"
$URI = “http://diegoalfa.com/app/AdminTool/2gt4e.php?val=“ + $valo
$HTML = Invoke-WebRequest -Uri $URI
($HTML.ParsedHtml.getElementsByTagName(‘div’) | Where{ $_.className -eq ‘token’ } ).innerText
($HTML.ParsedHtml.getElementsByTagName(‘div’) | Where{ $_.className -eq ‘prueba’ } ).innerText
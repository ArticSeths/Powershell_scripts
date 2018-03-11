cd C:\Users\user\Desktop\bot
cat ./nombres.txt | % {$nombre=$_;cat ./apellidos.txt | % {Write-Host $nombre $_}}

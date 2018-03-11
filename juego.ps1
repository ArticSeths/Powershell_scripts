if((Test-Path 'C:\Users\user\Documents\game\saves\player.txt') -like 'true'){
cls
write-host "existe"
}else{
newPlayer
}
function createPlayer {
    cls
    Write-host "-----------------------------------------------------------"
    Write-host "|                  Registrar nueva cuenta                 |"
    Write-host "-----------------------------------------------------------`n`n"
    [string]$playerName = read-host "Nombre"
    [string]$playerGenre = read-host "Genero [M] o [F]"
    [string]$playerClass = read-host "Clase [G], [N] o [M] (G=Gerrero ; N=Ninja ; M=Mago)"
    $playerName = 'name,'+$playerName
    $playerGenre= 'gen,'+$playerGenre
    $playerClass = 'class,'+$playerClass
    $playerExp = 'exp,0'
    New-Item -path C:\Users\user\Documents\game\saves -name player.txt
    $playerName | Out-File -FilePath C:\Users\user\Documents\game\saves\player.txt -Append
    $playerGenre | Out-File -FilePath C:\Users\user\Documents\game\saves\player.txt -Append
    $playerClass | Out-File -FilePath C:\Users\user\Documents\game\saves\player.txt -Append
    $playerExp | Out-File -FilePath C:\Users\user\Documents\game\saves\player.txt -Append
}

function newPlayer {
    cls
    Write-host "-----------------------------------------------------------"
    Write-host "|                 Bienvenido aventurero!                  |"
    Write-host "-----------------------------------------------------------`n`n"
    sleep -Milliseconds 500
    Write-host "-----------------------------------------------------------"
    write-host "Nuestro mundo esta en guerra por culpa de" -NoNewline
    write-host " los bandidos" -ForegroundColor Red
    write-host "y necesitamos tu ayuda para acabar con ellos!`n"
    write-host "Muchos de los aventureros que han entrado en esta batalla"
    write-host "no han sido capaces de vencer la maldad, pero tu, tienes"
    write-host "algo que puede vencer y recobrar la paz en nuestro mundo`n"
    write-host "¿Que me dices?"
    Write-host "-----------------------------------------------------------"
    $r = read-host "Indica tu respuesta [S] o [N]"
    if($r -like "s"){
        createPlayer
    }
}
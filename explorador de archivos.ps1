function menu{
cls
$lo = Get-location
    
    Write-Host "---------------------------------------------------------------------"
    Write-Host "- Estás en:"$lo.Path
    Write-Host "---------------------------- DIRECTORIOS ----------------------------"
    Get-ChildItem ./ | %{
        if($_.Attributes -like "Directory"){
        sleep -Milliseconds 1
            write-host ($_.name) -ForegroundColor Green
            
        }else{
        }
    }
    Write-Host "------------------------------ ARCHIVOS ------------------------------"
    Get-ChildItem ./ | %{
        if($_.Attributes -like "Directory"){
        
        }else{
            write-host $_.name
        }
    }
    Write-Host "----------------------------------------------------------------------"
    $c = Read-Host "Directorio"
    cd ./$c
    menu
}
menu
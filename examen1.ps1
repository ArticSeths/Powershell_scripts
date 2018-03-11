#1
ps | % {Add-Content -path C:\Users\user\Desktop\procesos.txt -Value ($_.ProcessName)}

$p = 0
$max = 10
function menu{
    $c = 0
    cls
    gc -Path C:\Users\user\Desktop\procesos.txt | % {
    $c++
    if($c -lt ($p*$max) -or $c -gt ($p*$max+$max)){

    }else{Write-Host $c $_}
    }
    $pags = $c/$max
    Write-Host "Pagina" $p "de" $pags
        if ($p -like 0){
            $r = Read-Host "1 pag sig"
            if ($r -like "1"){
                $p++
                menu
            }
        }
        if ($p -gt 0){
            $rp = Read-Host "1 pag sig | 2 pag ant"
            if ($rp -like "1"){
                $p++
                menu
            }
            if ($rp -like "2"){
                $p--
                menu
            }
        }
        if ($p -gt $pags){
            $r = Read-Host "2 pag ant"
            if ($r -like "2"){
                $p--
                menu
            }
        }
}
menu

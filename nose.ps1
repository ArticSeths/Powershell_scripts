Get-Content C:\Users\user\Desktop\script.txt | %{
$op=$_.split(',')[0]
$p1=$_.split(',')[1]
$p2=$_.split(',')[2]
$s = '1'

switch($op){
'abrir'{
Start-Process $p1
Start-Sleep -s $s
break
}
'escribir'{
[System.Windows.Forms.SendKeys]::SendWait($p1)
break
}
}
Start-Sleep -s $s
}
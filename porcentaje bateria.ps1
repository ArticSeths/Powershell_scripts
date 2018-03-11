while(0 -ne 1){
$i = ./adb shell dumpsys battery | select-string level
[string]$i = $i
$i.substring(9)+"%"
sleep -s 1
cls
}



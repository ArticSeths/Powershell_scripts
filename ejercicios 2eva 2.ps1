#1
ps | Select-Object * 
#2
$name = "ArticDir3x"
Get-WmiObject win32_process | % {
    if($_.getowner().user -like $name){
        $_.processname
    }
}
#3
$process = "virtualbox"
Get-WmiObject win32_process | Select-Object processname,processid | Select-String $process
#4
$id = "11720"
Get-WmiObject win32_process | Select-Object processname,processid | Select-String $id
#5
ps | sort cpu -Descending
#6
Get-WmiObject win32_process 
#7
(ps).Threads
#8
ps | Select-Object * | Format-Custom
#9
ps | Select-Object id,processname,pm,ws
#10
(ps).totalProcessorTime
#1
ps | Select-Object *

#2
(ps).UserProcessorTime

#3
(ps).Threads

#4
ps | Select-Object id,handles

#5
ps | sort cpu -descending

#6
$r = read-host "id"
ps | % $_{
 if($_.id -like $r){
    $_
 }
}
$content = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt
foreach($val1 in $content){
    New-Item -name $val1 -ItemType directory -path C:\Users\user\Documents\usuarios\

    $content2 = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt

    foreach($val2 in $content2){
        New-Item -name $val2 -ItemType directory -path C:\Users\user\Documents\usuarios\$val1
        $content3 = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt

        foreach($val3 in $content3){
            New-Item -name $val3 -ItemType directory -path C:\Users\user\Documents\usuarios\$val1\$val2\$val3

            $content4 = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt

            foreach($val4 in $content4){
                New-Item -name $val4 -ItemType directory -path C:\Users\user\Documents\usuarios\$val1\$val2\$val3\$val4
                $content5 = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt
                foreach($val5 in $content5){
                    New-Item -name $val5 -ItemType directory -path C:\Users\user\Documents\usuarios\$val1\$val2\$val3\$val4\$val5

                    $content6 = Get-Content C:\Users\user\Documents\usuarios\listaUsers.txt

                    foreach($val6 in $content6){
                        New-Item -name $val6 -ItemType directory -path C:\Users\user\Documents\usuarios\$val1\$val2\$val3\$val4\$val5\$val6
                    }
                }
            }
        }
    }
}
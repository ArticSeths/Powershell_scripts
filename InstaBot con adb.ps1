cd .\Desktop\platform-tools

#conectar via tcpip
./adb shell setprop service.adb.tcp.port 5555
./adb shell stop adbd
./adb shell start adbd
./adb tcpip 5555
./adb connect 10.0.1.11:5555
#desconectar
./adb kill-server

#---------empezar bot---------
./adb shell input keyevent 26
sleep -Seconds 1
./adb shell input swipe 500 1586 500 931
sleep -s 1
./adb shell monkey -p com.instagram.android -c android.intent.category.LAUNCHER 1
sleep -s 1
./adb shell input tap 537 1846

#bucle aqui
./adb shell am start -n tk.elevenk.proxysetter/.MainActivity -e host 192.126.170.81 -e port 3128 -e ssid Wifus -e key diegowert
sleep -s 5
sleep -Milliseconds 1000
./adb shell input tap 538 1465
sleep -Milliseconds 1000
./adb shell input tap 295 682
sleep -Milliseconds 1000
./adb shell input tap 926 1170
sleep -Milliseconds 1000
./adb shell input text "jesu.cristo.4597@gmail.com"
sleep -Milliseconds 1000
./adb shell input tap 522 1363
sleep -Milliseconds 1500
./adb shell input tap 255 740
sleep -Milliseconds 1000
cls
$name = "Jesus Marco"
$name = $name.replace(" ","%s")
./adb shell input text $name
sleep -Milliseconds 1000
./adb shell input keyevent 61
sleep -Milliseconds 1000
./adb shell input keyevent 61
sleep -Milliseconds 1500
./adb shell input text "simplemenos"
sleep -Milliseconds 1000
./adb shell input tap 497 1099
sleep -Milliseconds 1500
./adb shell input tap 522 1830
sleep -Milliseconds 1000
./adb shell input tap 290 1122
sleep -Milliseconds 1000
./adb shell input tap 522 1830
sleep -Milliseconds 1000
./adb shell input tap 290 1122
sleep -Milliseconds 1000
./adb shell input tap 987 114
sleep -Milliseconds 1000
./adb shell input tap 963 1843
sleep -Milliseconds 1000
./adb shell input tap 1000 120
sleep -Milliseconds 1000
./adb shell input swipe 493 1737 493 260
sleep -Milliseconds 500
./adb shell input swipe 493 1737 493 260
sleep -Milliseconds 500
./adb shell input tap 170 1637
sleep -Milliseconds 1000
./adb shell input tap 736 1055
sleep -Milliseconds 1000
./adb shell input tap 537 1846
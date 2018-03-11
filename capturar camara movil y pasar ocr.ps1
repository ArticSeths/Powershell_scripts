cd c:/adb
adb shell "am start -a android.media.action.IMAGE_CAPTURE"
sleep -s 1
adb shell "input keyevent 27"
sleep -s 1
adb shell "input keyevent 27"
$date = adb shell 'ls /storage/7BFD-5C57/DCIM/Camera/ | sort -r | head -1'
$date = $date.split('.')[0]
adb pull /storage/7BFD-5C57/DCIM/Camera/$date.jpg C:\Users\user\Desktop\imgs

$fichero = "C:\Users\user\Desktop\imgs\"+$date+".jpg"

$ocr = Get-TessTextFromImage -Path $fichero
$ocr.Text

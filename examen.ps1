Get-HotFix | group description
Get-Package | group vendor
(Get-Package).name | Select-String "Microsoft Office"
(get-package).count + (Get-HotFix).count
#Ej 2
Get-HotFix | group name
(Get-HotFix) | group name | Where-Object installedOn -notlike ""
(get-package) | group name
#A
Get-HotFix | group name > "C:\Users\user\Documents\EXAMEN\1.txt"
(Get-HotFix)  | Where-Object installedOn -notlike "" | group name > "C:\Users\user\Documents\EXAMEN\2.txt"
(get-package) | group name > "C:\Users\user\Documents\EXAMEN\3.txt"

Add-Content -Path "C:\Users\user\Documents\EXAMEN\4.txt" -Value ((Get-Content -Path "C:\Users\user\Documents\EXAMEN\1.txt") + (Get-Content -Path "C:\Users\user\Documents\EXAMEN\2.txt") + (Get-Content -path "C:\Users\user\Documents\EXAMEN\3.txt"))

#B
(Get-HotFix).hotfixid | % $_{
(Get-Package).name | Select-String $_
}
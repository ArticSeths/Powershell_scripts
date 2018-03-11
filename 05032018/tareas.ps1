$path = 'HKCU://Software/Microsoft/Windows/CurrentVersion/RunOnce'
$name = 'Powershell'

$powershell = 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'
$script = 'C:\Users\Admin\Documents\RETAMAR\Scripts_Powershell\05032018\script.ps1'

$value = $powershell+' '+$script
New-ItemProperty -Path $path -Name $name -Value $value -Force | Out-Null
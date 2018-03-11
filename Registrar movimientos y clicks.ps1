$ubi = $home+'\Desktop\new\coordenadas.txt'
$timer = New-Object System.Windows.Forms.Timer
  $timer.Interval = 1
  $timer.add_tick({
  $co = [System.Windows.Forms.Cursor]::Position
  [int]$cox = [int]$co.x - 50
  [int]$coy = [int]$co.y - 50
  $objForm.Location = New-Object System.Drawing.Size([int]$cox,[int]$coy)

    $tmil = $tmil +10
    start-sleep -milliseconds 1
    $co = [System.Windows.Forms.Cursor]::Position
    if ($cox -like $co.x -or $coy -like $co.y) {

    }else{
    $co = [System.Windows.Forms.Cursor]::Position
    $codata = 'mover,' + [string]$co.x + ','+ [string]$co.y + "`n"
    $codata | Out-File -FilePath $ubi -Append
    write-host $codata
    $codata = 'esperar,' + $tmil + "`n"
    $codata | Out-File -FilePath $ubi -Append
    write-host $codata
    $tmil = 0
    $cox = $co.x
    $coy = $co.y
    }
  })

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "click"
$objForm.Size = New-Object System.Drawing.Size(210,85) 
$objForm.StartPosition = "Manual"
$objForm.Opacity = 0.01

$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Location = New-Object System.Drawing.Size(0,0)
$btnStart.Size = New-Object System.Drawing.Size(140,35)
$btnStart.Text = "click!"

$btnStart.Add_Click({
    $co = [System.Windows.Forms.Cursor]::Position
    $codata = 'click,' + [string]$co.x + ','+ [string]$co.y + "`n"
    $codata | Out-File -FilePath $ubi -Append
    $objForm.Location = New-Object System.Drawing.Size(-1000,-1000)
    $MouseEventSig=@’
    [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
‘@
    $MouseEvent = Add-Type -memberDefinition $MouseEventSig -name “MouseEventWinApi” -passTh
    $MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
    $MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
    $objForm.TopMost=$True
})

$objForm.Controls.Add($btnStart)

$timer.start()
$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()
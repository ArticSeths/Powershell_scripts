$nic = gwmi -computer . -class "win32_networkadapterconfiguration" | Where-Object {$_.defaultIPGateway -ne $null}
$IP = $nic.ipaddress | select-object -first 1
#$ClientMask = $nic.ipsubnet | select-object -first 1
$ClientMask = "255.0.0.0"
$mk1 = $ClientMask.Split('.')[0]
$mk2 = $ClientMask.Split('.')[1]
$mk3 = $ClientMask.Split('.')[2]
$mk4 = $ClientMask.Split('.')[3]

$mk4=(254-$mk4)
$mk3=(254-$mk3)
$mk2=(254-$mk2)
$mk1=(254-$mk1)

if($mk4 -le 0){$mk4=1}
if($mk3 -le 0){$mk3=1}
if($mk2 -le 0){$mk2=1}
if($mk1 -le 0){$mk1=1}
$pcs=$mk1*$mk2*$mk3*$mk4

$pcs

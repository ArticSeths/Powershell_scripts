cls
$r=Invoke-WebRequest https://diegoalfa.com/app/post/post.php
$form = $r.Forms[0]
$form.Fields["user"] = "user"
$form.Fields["pass"] = "pass"
$form.Fields["sub"] = "1"
$r=Invoke-WebRequest -Uri ("https://diegoalfa.com/app/post/" + $form.Action) -Method POST -Body $form.Fields
if($r.Content -notmatch "0"){
Write-Host "Verda"
}else{
Write-Host "Falso"
}

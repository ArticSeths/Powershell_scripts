cls
#$string = "tengo algo que decirle a tu amigo, pero no puede saberlo ya que es un secreto";
$string = gc C:\Users\user\Desktop\libros\ANEKDOTLAR03.txt
$obj = @{}
$string -replace '[^a-z]' -split '(?=\w)' | % {
    if([bool]($obj.Keys -match $_)){$obj.$_++}else{$obj.Add($_,1)}
}
$esp = "ea";$aze = "ai";$ing = "et";$ale = "en";$Leng = ""
$obj.GetEnumerator() | Sort-Object -Property Value -Descending | select -first 2 | %{
$Leng = $Leng + $_.Key
}
if($Leng -like $esp){
echo "Este texto esta en español";
}elseif($Leng -like $ing){
echo "Este texto esta en ingles";
}elseif($Leng -like $ale){
echo "Este texto esta en Aleman";
}elseif($Leng -like $aze){
echo "Este texto esta en Azerbaiyano";
}else{
echo "No se ha encontrado un resultado"
}
#█ [a][__________________________________________________] 20%

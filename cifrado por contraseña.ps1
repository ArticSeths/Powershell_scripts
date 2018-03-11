cls
ls C:\Users\user\Desktop\cifrado -File | % {
    function cifrar($str){
        $ret = "";$str -split '' | %{if($_ -eq " "){$ret = $ret+" "}else{$a = [string]$_;$obj.Keys | %{if($obj[[string]$_] -eq $a){$ret = $ret+$_}}}};return $ret;
    }

    function descifrar($str){
        $ret = "";$str -split '' | %{if($_ -eq " "){$ret = $ret+" "}else{$ret = $ret+$obj[[string]$_]}};return $ret;
    }
    function pass($length){
       $ret='';for($i=0;$i -ne $length;$i++) {$ret=$ret+[char](Get-Random -Maximum 122 -Minimum 97)};return $ret;
    }

    $pass = pass(Get-Random -Maximum 16 -Minimum 8)
    $i = 96;$obj = @{};$pass -replace '' -split '' | %{if($_ -ne " "){if(![bool]($obj[[string]$_])){$obj[$_] = [char]$i++}}}
    97..122 | % {if(![bool]($obj[[string]([char]$_)])){$obj[[string]([char]$_)] = [char]$i++}}


    $str = gc $_.FullName
    cifrar($str) >> C:\Users\user\Desktop\cifrado\cifrado\$pass
    echo $_.FullName "->" $pass
}

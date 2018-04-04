$a = 0..254
$out = @()
$a | foreach {
    $b = [char]$_
    $output = [PsCustomObject]@{
        Number = $_
        Letter = $b
    }
    $out += $output
    #write-host "$($_) $($b)"
} 
$out | fl

$c = "D"

[System.Collections.ArrayList]$arraylist = "HomePC01", "HomeFIL02", "HomeHTPC01"
$arraylist
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

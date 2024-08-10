[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Word
)  
process {
    $trimmedWord = $Word.TrimEnd("o")
    $masculineSingular = $Word
    $feminineSingular = $trimmedWord + "a"
    $masculinePlural = $trimmedWord + "i"
    $femininePlural = $trimmedWord + "e"
    Write-Host ("{0}, {1}, {2}, {3}" -f $masculineSingular, $feminineSingular, $masculinePlural, $femininePlural)
}
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $word
)
# Generate masculine, feminine, singular, and plural permutations of a given word
process {
    Write-Host "$word (masculine singular) = "
    Write-Host "$word (feminine singular) = "
    Write-Host "$word (masculine plural) = "
    Write-Host "$word (feminine plural) = "
}
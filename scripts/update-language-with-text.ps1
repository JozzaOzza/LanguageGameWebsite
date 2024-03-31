[CmdletBinding()]
param (
   [Parameter()]
   [string]$Languages = ""
)
begin {
    $languagesList = (($Languages -eq "*") -or ($Languages -eq "")) ? @("french", "italian", "portuguese", "spanish") : ($Languages.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $types = @("adjectives", "adverbs", "extras", "nouns")
}
process {
    foreach ($language in $languagesList) {
        Write-Host $language
        foreach ($type in $types) {
            $sourcePath = "..\data\$language\$language-$type.txt"
            $destinationPath = "..\data\$language\$language-$type.json"
            $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
            $category = ""
            $inCategory = $false
            
            Get-Content -Path $sourcePath | ForEach-Object {
                if (!$inCategory) {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $inCategory = $true
                    }
                } else {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                    } elseif ($_.Trim() -ne "") {
                        $lineSplit = $_.Split("=")
                        $english = $lineSplit[0].Trim()
                        $translation = $lineSplit[1].Trim()
                        if ($destinationJson[$type][$category].Keys -contains $english) {
                            $destinationJson[$type][$category][$english] = $translation
                        }
                    }
                }
            }
            $destinationJson | ConvertTo-Json -depth 100 | Out-File "..\data\$language\$language-$type.json"
        }
        
    }
}
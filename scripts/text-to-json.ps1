[CmdletBinding()]
param (
   [Parameter(Mandatory = $true)]
   [string]$Languages
)
begin {
    $languages = ($Languages -eq "*") ? @("french", "italian", "portuguese", "spanish") : ($Languages.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $types = @("adjectives", "adverbs", "extras", "nouns", "verbs")
}
    
process {
    foreach ($language in $languages) {
        $jsonRepresentation = @{"language" = $language; "types" = @{}}
        foreach ($type in $types) {
            $source = "..\data\$language\$language-$type.txt"
            $jsonRepresentation["types"].Add($type, @{})
            $category = ""
            $inCategory = $false
            Get-Content -Path $source | ForEach-Object {
                if (!$inCategory) {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $inCategory = $true
                        $jsonRepresentation["types"][$type].Add($category, @{})
                    }
                } else {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $jsonRepresentation["types"][$type].Add($category, @{})
                    } elseif ($_.Trim() -ne "") {
                        $equalIndex = $_.IndexOf("=")
                        $key = $_.Substring(0, $equalIndex).Trim()
                        $value = $_.Substring($equalIndex + 1).Trim()
                        $jsonRepresentation["types"][$type][$category].Add($key, $value)
                    }
                }
            }
        }
        $jsonRepresentation | ConvertTo-Json -depth 100 | Out-File "..\data\$language\$language.json"
    }
}
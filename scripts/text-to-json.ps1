[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Languages
)
begin {
    $languages = ($Languages -eq "*") ? @("french", "italian", "portuguese", "spanish") : ($Languages.Split(",") | ForEach-Object { $_.Trim().ToLower() })
    # verbs kept separately due to structure
    $types = @("adjectives", "adverbs", "extras", "nouns")
} 
process {
    # define function for adding words to verbs section
    function New-VerbObject {
        param (
            [string]$Line
        )
        $splitLine = $Line.Split("=")
        $conjugations = $splitLine[1].Split(",") | ForEach-Object { $_.Trim("(", ")", " ") }
        $conjugationsObject = @{"infinitive" = $conjugations[0]; "I" = $conjugations[1]; "you (singular)" = $conjugations[2]; "they (singular)" = $conjugations[3]; "we" = $conjugations[4]; "you (plural)" = $conjugations[5]; "they (plural)" = $conjugations[6] }
        return $conjugationsObject
    }

    foreach ($language in $languages) {
        $jsonRepresentation = @{"language" = $language }
        # loop through all non-verb types
        foreach ($type in $types) {
            $source = "..\data\$language\$language-$type.txt"
            $jsonRepresentation[$type] = @{}
            $category = ""
            $inCategory = $false
            Get-Content -Path $source | ForEach-Object {
                if (!$inCategory) {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $inCategory = $true
                        $jsonRepresentation[$type][$category] = @{}
                    }
                }
                else {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $jsonRepresentation[$type][$category] = @{}
                    }
                    elseif ($_.Trim() -ne "") {
                        $splitLine = $_.Split("=")
                        $key = $splitLine[0].Trim().ToLower()
                        $value = $splitLine[1].Trim().ToLower()
                        $jsonRepresentation[$type][$category][$key] = $value
                    }
                }
            }
        }
        # loop through verbs
        $source = "..\data\$language\$language-verbs.txt"
        $jsonRepresentation.Add("verbs", @{})
        $category = ""
        $inCategory = $false
        Get-Content -Path $source | ForEach-Object {
            if (!$inCategory) {
                if ($_ -match "(Category)") {
                    $category = $_.Substring(11).Trim().ToLower()
                    $inCategory = $true
                    $jsonRepresentation["verbs"][$category] = @{}
                }
            }
            else {
                if ($_ -match "(Category)") {
                    $category = $_.Substring(11).Trim().ToLower()
                    $jsonRepresentation["verbs"][$category] = @{}
                }
                elseif ($_.Trim() -ne "") {
                    $verb = $_.Split("=")[0].Trim().ToLower()
                    $conjugations = New-VerbObject -Line $_.ToLower()
                    $jsonRepresentation["verbs"][$category][$verb] = $conjugations
                }
            }
        }
        $jsonRepresentation | ConvertTo-Json -depth 100 | Out-File "..\data\$language\$language.json"
    }
}
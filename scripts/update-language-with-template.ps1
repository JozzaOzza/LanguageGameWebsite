[CmdletBinding()]
param ()
begin {
    $languages = @("french", "italian", "portuguese", "spanish")
    # verbs kept separately due to structure
    $types = @("adjectives", "adverbs", "extras", "nouns")
} 
process {
    foreach ($language in $languages) {
        # loop through all non-verb types
        foreach ($type in $types) {
            $sourcePath = "..\data\template\template-$type.json"
            $destinationPath = "..\data\$language\$language-$type.json"
            $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
            $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
            $blankPath = "..\data\$language\blank\$type.json"

            # new object to be added to
            $newJson = $sourceJson

            $newJson["language"] = $language
            $newJson | ConvertTo-Json -depth 100 | Out-File $blankPath
            $sourceCategories = $sourceJson[$type].Keys

            # update destination's categories with latest words, if they do not already exist
            foreach ($key in $sourceCategories) {
                $sourceJson[$type][$key].Keys.Clone() | ForEach-Object {
                    Write-Host ("{0} : {1}" -f $_, $destinationJson[$type][$key][$_])
                    $sourceJson[$type][$key][$_] = ($null -eq $destinationJson[$type][$key][$_]) ? $sourceJson[$type][$key][$_] : $destinationJson[$type][$key][$_]
                }
            }

            $newJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
        }
        # loop through verb type
        $sourcePath = "..\data\template\template-verbs.json"
        $destinationPath = "..\data\$language\$language-verbs.json"
        $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
        $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
        $blankPath = "..\data\$language\blank\verbs.json"

        # new object to be added to
        $newJson = $sourceJson

        $newJson["language"] = $language
        $newJson | ConvertTo-Json -depth 100 | Out-File $blankPath
        $sourceCategories = $sourceJson["verbs"].Keys

        # update destination's categories with latest words, if they do not already exist
        foreach ($key in $sourceCategories) {
            $sourceJson["verbs"][$key].Keys.Clone() | ForEach-Object {
                Write-Host ("{0} : {1}" -f $_, $destinationJson["verbs"][$key][$_])
                $sourceJson["verbs"][$key][$_] = ($null -eq $destinationJson["verbs"][$key][$_]) ? $sourceJson["verbs"][$key][$_] : $destinationJson["verbs"][$key][$_]
            }
        }

        $newJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
    }
    
}
    
# for testing
# $sourcePath = "..\data\template\template-nouns.json"
# $destinationPath = "..\data\spanish\spanish-nouns.json"
# $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
# $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
# $destinationJson["nouns"]["food (common dishes)"].Keys
# $destinationJson["nouns"]["food (common dishes)"].Keys -notcontains "sandwich"
# $destinationJson["nouns"]["food (common dishes)"]["sandwich"]

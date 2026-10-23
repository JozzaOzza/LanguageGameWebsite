[CmdletBinding()]
param ()
begin {
    $languages = @("french", "italian", "portuguese", "spanish")
    # verbs kept separately due to structure
    $types = @("adjectives", "adverbs", "extras", "nouns")
    $types = @("extras")
} 
process {
    foreach ($language in $languages) {
        # loop through all non-verb types
        foreach ($type in $types) {
            $sourcePath = "..\data\$language\$language-$type.txt"
            $destinationPath = "..\data\$language\$language-$type.json"
            $destinationJson = @{"language" = "template"; $type = @{}}

            $category = ""
            $inCategory = $false
            # loop through lines of the text file
            Get-Content -Path $sourcePath | ForEach-Object {
                if (!$inCategory) {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                        $inCategory = $true
                        $destinationJson[$type][$category] = @{}
                    }
                }
                else {
                    if ($_ -match "(Category)") {
                        $category = $_.Substring(11).Trim().ToLower()
                    }
                    elseif ($_.Trim() -ne "") {
                        $splitLine = $_.Split("=")
                        $key = $splitLine[0].Trim().ToLower()
                        $value = $splitLine[1].Trim().ToLower()
                        $destinationJson[$type][$category][$key] = $value
                    }
                }
            }

            $destinationJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
        }
    }
    # loop through verb type
    # $sourcePath = "..\data\template\template-verbs.json"
    # $destinationPath = "..\data\$language\$language-verbs.json"
    # $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
    # $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
    # $blankPath = "..\data\$language\blank\verbs.json"

    # # new object to be added to
    # $newJson = @{"language" = $language; "verbs" = @{} }

    # $sourceCategories = $sourceJson["verbs"].Keys

    # # update destination's categories with latest words, if they do not already exist
    # foreach ($key in $sourceCategories) {
    #     $sourceCategoryWords = $sourceJson["verbs"][$key].Keys
    #     foreach ($word in $sourceCategoryWords) {
    #         $newJson["verbs"][$key][$word] = $destinationJson["verbs"][$key][$word]
    #     }
    # }

    # $newJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
    # $newJson | ConvertTo-Json -depth 100 | Out-File $blankPath
}
    
# for testing
# $sourcePath = "..\data\template\template-nouns.json"
# $destinationPath = "..\data\spanish\spanish-nouns.json"
# $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
# $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
# $destinationJson["nouns"]["food (common dishes)"].Keys
# $destinationJson["nouns"]["food (common dishes)"].Keys -notcontains "sandwich"
# $destinationJson["nouns"]["food (common dishes)"]["sandwich"]

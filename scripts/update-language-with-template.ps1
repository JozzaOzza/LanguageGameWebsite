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

            # new object to be added to
            $newJson = @{"language" = $language; $type = @{} }

            $sourceCategories = $sourceJson[$type].Keys

            # update destination's type with latest categories, if they do not already exist
            foreach ($key in $sourceCategories) {
                $newJson[$type].Add($key, @{})
            }

            # update destination's categories with latest words, if they do not already exist
            foreach ($key in $sourceCategories) {
                $sourceCategoryWords = $sourceJson[$type][$key].Keys
                $destinationCategoryWords = $destinationJson[$type][$key].Keys
                foreach ($word in $sourceCategoryWords) {
                    if ($destinationCategoryWords -notcontains $word) {
                        $newJson[$type][$key].Add($word, $sourceJson[$type][$key][$word])
                    }
                    else {
                        $newJson[$type][$key].Add($word, $destinationJson[$type][$key][$word])
                    }
                }
            }

            $newJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
        }
        # loop through verb type
        $sourcePath = "..\data\template\template-verbs.json"
        $destinationPath = "..\data\$language\$language-verbs.json"
        $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
        $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100

        # new object to be added to
        $newJson = @{"language" = $language; "verbs" = @{} }

        $sourceCategories = $sourceJson["verbs"].Keys

        # update destination's type with latest categories, if they do not already exist
        foreach ($key in $sourceCategories) {
            $newJson["verbs"].Add($key, @{})
        }

        # update destination's categories with latest words, if they do not already exist
        foreach ($key in $sourceCategories) {
            $sourceCategoryWords = $sourceJson["verbs"][$key].Keys
            $destinationCategoryWords = $destinationJson["verbs"][$key].Keys
            foreach ($word in $sourceCategoryWords) {
                if ($destinationCategoryWords -notcontains $word) {
                    $newJson["verbs"][$key].Add($word, $sourceJson["verbs"][$key][$word])
                }
                else {
                    $newJson["verbs"][$key].Add($word, $destinationJson["verbs"][$key][$word])
                }
            }
        }

        $newJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
    }
    
    # for testing
    # $sourcePath = "..\data\template\template-nouns.json"
    # $destinationPath = "..\data\spanish\spanish-nouns.json"
    # $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
    # $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
    # $destinationJson["nouns"]["food (common dishes)"].Keys
    # $destinationJson["nouns"]["food (common dishes)"].Keys -notcontains "sandwich"
    # $destinationJson["nouns"]["food (common dishes)"]["sandwich"]
}
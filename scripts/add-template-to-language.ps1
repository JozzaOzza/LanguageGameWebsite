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
            # get template based on type
            # set language based on json["language"]

            $sourcePath = "..\data\template\template-$type.json"
            $destinationPath = "..\data\$language\$language-$type.json"
            $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
            $destinationJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100

            $topLevelKeys = $sourceJson.Keys
            $typeLevelKeys = $sourceJson[$type].Keys

            # update destination with latest language and type
            foreach ($key in $topLevelKeys) {
                $destinationJson.Add($key, $sourceJson[$key])
            }
            $destinationJson.language = $language

            # update destination's type with latest categories
            foreach ($key in $typeLevelKeys) {
                $destinationJson[$type].Add($key, $sourceJson[$type][$key])
            }

            # update destination's categories with latest words
            foreach ($key in $typeLevelKeys) {
                $categoryLevelKeys = $sourceJson[$type][$key].Keys
                foreach ($word in $categoryLevelKeys) {
                    $destinationJson[$type][$key].Add($word, $sourceJson[$type][$key][$word])
                }
            }

            $destinationJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
        }
        # loop through verb type
        $sourcePath = "..\data\template\template-verbs.json"
        $destinationPath = "..\data\$language\$language-verbs.json"
        $sourceJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100
        $destinationJson = Get-Content -Raw $sourcePath | ConvertFrom-Json -AsHashTable -Depth 100

        $topLevelKeys = $sourceJson.Keys
        $typeLevelKeys = $sourceJson[$type].Keys

        # add destination with latest language and type
        foreach ($key in $topLevelKeys) {
            $destinationJson.Add($key, $sourceJson[$key])
        }
        $destinationJson.language = $language

        # add destination's type with latest categories
        foreach ($key in $typeLevelKeys) {
            $destinationJson["verbs"].Add($key, $sourceJson["verbs"][$key])
        }

        # add destination's categories with latest words
        foreach ($key in $typeLevelKeys) {
            $categoryLevelKeys = $sourceJson["verbs"][$key].Keys
            foreach ($word in $categoryLevelKeys) {
                $destinationJson["verbs"][$key].Add($word, $sourceJson["verbs"][$key][$word])
            }
        }

        $destinationJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
    }
}
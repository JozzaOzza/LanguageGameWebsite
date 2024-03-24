[CmdletBinding()]
param ()
begin {
    $languages = @("french", "italian", "portuguese", "spanish")
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
        # loop through verbs
        $sourcePath = "..\data\template\template-verbs.json"
        $destinationPath = "..\data\$language\$language-verbs.json"
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
}
using namespace System.Collections.Generic
# Run only if the 
# Run this script to generate randomised lists of verb conjugations, of 50 in length, for all languages
# & '.\verbs-generate-random-lists.ps1'
[CmdletBinding()]
param ()  
process {
    # Set path to target files
    $dataPath = ".\data"

    # Set output naming convention
    $outputFileNameSuffix = "-verb-practice-random"

    # Get languages
    $languageList = Get-ChildItem -Path ("{0}\*" -f $dataPath) -Name -Include "*-verb-practice.json"
    $languageNumberedList = [System.Collections.Generic.List[string]]@()
    foreach ($language in $languageList) {
        # Get language name
        $languageName = ($language -split "-")[0]

        # Get chosen language
        $destinationJson = Get-Content -Raw ("{0}\{1}" -f $dataPath, $language) | ConvertFrom-Json -AsHashTable -Depth 100
    
        # Get tenses
        $tenseList = $destinationJson.Keys
        $tenseCount = $tenseList.Count
        $tenseNumber = 0
        $tenseObject = $destinationJson[$tenseList[$tenseNumber]]

        # Get verbs and conjugations
        $verbList = $tenseObject.Keys
        $conjugateList = $tenseObject[$verbList[0]].Keys
        $verbCount = $verbList.Count
        $conjugateCount = $conjugateList.Count
        $totalConjugations = ($tenseCount * $verbCount * $conjugateCount)
        Write-Host ("There are {0} total conjugations in the file. {1} tenses, {2} verbs per tense, and {3} conjugations per verb" -f $totalConjugations, $tenseCount, $verbCount, $conjugateCount)

        # Generate list of 'coordinates' which we can use to randomly search for verb conjugations
        $tenseVerbConjugateNumberList = [System.Collections.Generic.List[List[int]]]@()
        for ($tense = 0; $tense -lt $tenseCount; $tense++) {
            for ($verb = 0; $verb -lt $verbCount; $verb++) {
                for ($conjugate = 0; $conjugate -lt $conjugateCount; $conjugate++) {
                    $tenseVerbConjugateNumberList.Add(@($tense, $verb, $conjugate))
                }   
            }
        }
        $coordinatesCount = $tenseVerbConjugateNumberList.Count

        $iterator = 0
        $groupNumber = 0
        $groupLength = 50
        $outputHashtable = @{}
    
        while ($iterator -lt $coordinatesCount) {
            # Find remainder of current iterator divided by 50. If equal to 0, then increase the group number
            # This will mean that the next conjugation is added to a new group
            $remainder = $iterator % $groupLength
            if ($remainder -eq 0) {
                $groupNumber++
                $groupName = ("group-{0}" -f $groupNumber)
                $outputHashtable[$groupName] = @{}
            } 
            $iterator++

            # Select randomly from coordinates list, and remove that coordinate
            $currentCoordinateIndex = (Get-Random -Maximum $coordinatesCount)
            $currentCoordinate = $tenseVerbConjugateNumberList[$currentCoordinateIndex]
            [void]$tenseVerbConjugateNumberList.remove($currentCoordinate)
            $coordinatesCount--

            # Use coordinates to retrive current verb and conjugation
            $currentTenseNumber = $currentCoordinate[0]
            $currentTense = $tenseList[$currentTenseNumber]
            $currentVerbNumber = $currentCoordinate[1]
            $currentVerb = $verbList[$currentVerbNumber]
            $currentConjugateNumber = $currentCoordinate[2]
            $currentConjugate = $conjugateList[$currentConjugateNumber]
            $currentAnswer = $destinationJson[$currentTense][$currentVerb][$currentConjugate]
        
            # $currentTense
            # $currentVerb
            # $currentConjugate
            # $currentAnswer
        
            # Add conjugation to group in output
            $keyName = ("{0} - {1} - {2}" -f $currentVerb, $currentConjugate, $currentTense)
            $keyName
            $outputHashtable[$groupName][$keyName] = $currentAnswer
        }

        # Generate JSON file with output
        $outputFileName = ("{0}{1}" -f $languageName, $outputFileNameSuffix)
        $outputHashtable | ConvertTo-Json -depth 100 | Out-File ("{0}\{1}.json" -f $dataPath, $outputFileName)
    }
}
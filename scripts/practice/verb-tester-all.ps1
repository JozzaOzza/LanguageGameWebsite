using namespace System.Collections.Generic
# Tests against all conjugations for all verbs for all tenses, in a random order
# & '.\verb-tester-all.ps1'
[CmdletBinding()]
param ()  
process {
    # Set path to target files
    $dataPath = ".\data"
    $accentsPath = ".\data\accent-marks.json"

    # Get languages
    $languageList = Get-ChildItem -Path ("{0}\*" -f $dataPath) -Name -Include "*-verb-practice.json"
    $languageIterator = 1
    $languageNumberedList = ""
    foreach ($language in $languageList) {
        # Each file name will have the format '<language name>-verb-practice.json'. We want the first part
        $languageNumberedList += ("`n({0}) {1}" -f $languageIterator, $language.Split("-")[0])
        $languageIterator++
    }

    # Get chosen language from user
    $languageResponse = Read-Host ("Pick a language. The options are:{0}`n" -f $languageNumberedList)
    $languageResponseNumber = ([int]$languageResponse) - 1
    $languageName = $languageList[$languageResponseNumber].Split("-")[0]
    $destinationPath = ("{0}\{1}" -f $dataPath, $languageList[$languageResponseNumber])
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100

    # Get accent marks file
    $accentsJson = Get-Content -Raw $accentsPath | ConvertFrom-Json -AsHashTable -Depth 100
    $accentsString = $accentsJson[$languageName]
    
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
    $testLength = 50
    Write-Host ("There are {0} total conjugations in the file. {1} tenses, {2} verbs per tense, and {3} conjugations per verb" -f $totalConjugations, $tenseCount, $verbCount, $conjugateCount)
    $totalQuestions = 0
    $correctAnswers = 0

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
    
    while ($totalQuestions -lt $testLength) {
        $totalQuestions++

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
        
        # Ask question and collect response
        $currentResponse = Read-Host ("Conjugate the verb '{0}', in '{1}' form, for the tense '{2}'. Accent marks: {3}" -f $currentVerb, $currentConjugate, $currentTense, $accentsString)

        # Check response against correct answer, and generate output
        if ($currentResponse.Trim().ToLower() -in ($currentAnswer.Split(", "))) {
            $currentOutput, $currentOutputColour, $correctAnswers = ("Correct - {0}" -f $currentAnswer), "Green", ($correctAnswers + 1)
        }
        else {
            $currentOutput, $currentOutputColour = ("Wrong - {0}" -f $currentAnswer), "Red"
        }

        Write-Host ("{0} - {1}/{2}" -f $currentOutput, $correctAnswers, $totalQuestions) -ForegroundColor $currentOutputColour
    }
}
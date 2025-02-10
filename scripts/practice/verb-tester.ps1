using namespace System.Collections.Generic

# Tense chosen by user: & ".\verb-tester.ps1"
# Tense randomly chosen: & ".\verb-tester.ps1" -RandomTense
[CmdletBinding()]
param (
    [switch]$RandomTense
)  
process {
    # Set path to target files
    $dataPath = ".\data"

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
    $destinationPath = ("{0}\{1}" -f $dataPath, $languageList[$languageResponseNumber])
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
    
    # Get tenses
    $tensesList = $destinationJson.Keys
    $tensesListLength = $tensesList.Count
    
    # Get random tense
    if ($RandomTense) {
        Write-Host ("Number of tenses: {0}" -f $tensesListLength)
        $randomNumber = Get-Random -Maximum $tensesListLength
        Write-Host ("Random number: {0}" -f $randomNumber)
        $tenseObject = $destinationJson[$tensesList[$randomNumber]]
    }
    # Get tense from user
    else {
        $tensesIterator = 1
        $tensesNumberedList = ""
        foreach ($tense in $tensesList) {
            $tensesNumberedList += ("`n({0}) {1}" -f $tensesIterator, $tense)
            $tensesIterator++
        }
        $tenseResponse = Read-Host ("Pick a tense. The options are:{0}`n" -f $tensesNumberedList)
        $tenseResponseNumber = ([int]$tenseResponse) - 1
        $tenseObject = $destinationJson[$tensesList[$tenseResponseNumber]]
    }

    $verbsList = $tenseObject.Keys
    $conjugateList = $tenseObject[$verbsList[0]].Keys

    # Make length of test equal to 25, or lower depending on amount of possible conjugations
    $totalPermutations = ($tenseObject.Keys.Count * $tenseObject[$verbsList[0]].Keys.Count)
    $testLength = ($totalPermutations -lt 25) ? $totalPermutations : 25

    $totalQuestions = 0
    $correctAnswers = 0

    # Generate list of 'coordinates' which we can use to randomly search for verb conjugations
    $verbAndConjugateNumberList = [System.Collections.Generic.List[List[int]]]@()
    for ($verbNumber = 0; $verbNumber -lt $verbsList.Count; $verbNumber++) {
        for ($conjugateNumber = 0; $conjugateNumber -lt $conjugateList.Count; $conjugateNumber++) {
            $verbAndConjugateNumberList.Add(@($verbNumber, $conjugateNumber))
        }   
    }
    $coordinatesCount = $verbAndConjugateNumberList.Count
    
    while ($totalQuestions -lt $testLength) {
        $totalQuestions++

        # Select randomly from coordinates list, and remove that coordinate
        $currentCoordinateIndex = (Get-Random -Maximum $coordinatesCount)
        $currentCoordinate = $verbAndConjugateNumberList[$currentCoordinateIndex]
        [void]$verbAndConjugateNumberList.remove($currentCoordinate)
        $coordinatesCount--

        # Use coordinates to retrive current verb and conjugation
        $currentVerbNumber = $currentCoordinate[0]
        $currentConjugationNumber = $currentCoordinate[1]
        $currentVerb = $tenseObject[$verbsList[$currentVerbNumber]]
        $currentConjugationAnswer = $currentVerb[$conjugateList[$currentConjugationNumber]]
        
        # Ask question and collect response
        $currentResponse = Read-Host ("Conjugate the verb '{0}', in '{1}' form, for the tense '{2}'" -f $verbsList[$currentVerbNumber], $conjugateList[$currentConjugationNumber], $tensesList[$tenseResponseNumber])

        # Check response against correct answer, and generate output
        if ($currentResponse.Trim().ToLower() -in ($currentConjugationAnswer.Split(", "))) {
            $currentOutput, $currentOutputColour, $correctAnswers = ("Correct - {0}" -f $currentConjugationAnswer), "green", ($correctAnswers + 1)
        }
        else {
            $currentOutput, $currentOutputColour = ("Wrong - {0}" -f $currentConjugationAnswer), "red"
        }

        Write-Host ("{0} - {1}/{2}" -f $currentOutput, $correctAnswers, $totalQuestions) -ForegroundColor $currentOutputColour
    }
}
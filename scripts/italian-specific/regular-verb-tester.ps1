using namespace System.Collections.Generic

[CmdletBinding()]
param ()  
process {
    $destinationPath = ".\regular-verb-answers.json" 
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100
    
    $tensesList = $destinationJson.Keys
    $tensesIterator = 1
    $tensesNumberedList = ""
    
    foreach ($tense in $tensesList) {
        $tensesNumberedList += ("`n({0}) {1}" -f $tensesIterator, $tense)
        $tensesIterator++
    }
    
    $tenseResponse = Read-Host ("Pick a tense. The options are:{0}" -f $tensesNumberedList)
    $tenseResponseNumber = ([int]$tenseResponse) - 1
    $tenseObject = $destinationJson[$tensesList[$tenseResponseNumber]]
    $verbsList = $tenseObject.Keys
    $conjugateList = $tenseObject[$verbsList[0]].Keys

    $totalQuestions = 0
    $correctAnswers = 0

    # Generate list of 'coordinates' which we can use to randomly search for verb conjugations
    $verbAndConjugateNumberList = [System.Collections.Generic.List[List[int]]]@()
    for ($verbNumber = 0; $verbNumber -lt 9; $verbNumber++) {
        for ($conjugateNumber = 0; $conjugateNumber -lt 6; $conjugateNumber++) {
            $verbAndConjugateNumberList.Add(@($verbNumber, $conjugateNumber))
        }   
    }
    $coordinatesCount = $verbAndConjugateNumberList.Count
    
    while ($totalQuestions -lt 25) {
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
        } else {
            $currentOutput, $currentOutputColour = ("Wrong - {0}" -f $currentConjugationAnswer), "red"
        }

        Write-Host ("{0} - {1}/{2}" -f $currentOutput, $correctAnswers, $totalQuestions) -ForegroundColor $currentOutputColour
    }
}
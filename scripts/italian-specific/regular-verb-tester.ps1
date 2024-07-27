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
    
    while ($totalQuestions -lt 25) {
        $totalQuestions++

        # There are 9 verbs to choose from, pick one randomly
        $currentVerbNumber = Get-Random -Maximum 9
        $currentVerb = $tenseObject[$verbsList[$currentVerbNumber]]
        
        # There are 6 conjugations to choose from, pick one randomly
        $currentConjugationNumber = Get-Random -Maximum 6
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
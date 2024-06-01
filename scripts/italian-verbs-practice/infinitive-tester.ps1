[CmdletBinding()]
param ()  
process {
    $destinationPath = "..\..\data\italian\italian-verbs.json" 
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100

    $sectionResponse = Read-Host ("Pick a section. Options are from 1 to 5")
    $sectionString = ($sectionResponse.Trim() -eq 1) ? "common" : ("common ({0})" -f $sectionResponse.Trim())
    
    $section = $destinationJson["verbs"][$sectionString]
    $sectionKeys = $section.Keys

    $totalQuestions = 0
    $correctAnswers = 0
    
    foreach ($verb in $sectionKeys) {
        ++$totalQuestions
        $testResponse = Read-Host ("What is the infinitive form of the verb '$verb'")
        $testCorrectAnswer = $section[$verb]["infinitive"]
        $testCorrectAnswerList = $testCorrectAnswer.Split(", ")
        
        if ($testResponse.Trim().ToLower() -in $testCorrectAnswerList) {
            $testOutput, $testOutputColour, $correctAnswers = ("Correct - {0}" -f $testCorrectAnswer), "green", ($correctAnswers + 1)
        } else {
            $testOutput, $testOutputColour = ("Wrong - {0}" -f $testCorrectAnswer), "red"
        }

        Write-Host ("{0} - {1}/{2}" -f $testOutput, $correctAnswers, $totalQuestions) -ForegroundColor $testOutputColour
    }
}
using namespace System.Collections.Generic

[CmdletBinding()]
param ()  
process {
    $destinationPath = "..\..\data\italian\italian-verbs.json" 
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100

    $sectionResponse = Read-Host ("Pick a section. Options are from 1 to 5")
    $sectionString = ($sectionResponse.Trim() -eq 1) ? "common" : ("common ({0})" -f $sectionResponse.Trim())
    
    $section = $destinationJson["verbs"][$sectionString]
    $sectionKeys = $section.Keys
    $coordinates = [System.Collections.Generic.List[int]]@()
    for ($verb = 0; $verb -lt $sectionKeys.Count; $verb++) {
        $coordinates.Add($verb)
    }
    $initialCount = $sectionKeys.Count
    $initialCount

    $totalQuestions = 0
    $correctAnswers = 0
    
    while ($totalQuestions -lt $sectionKeys.Count) {
        ++$totalQuestions

        # Select randomly from coordinates list, and remove that coordinate
        $currentIndex = $coordinates[(Get-Random -Maximum ($initialCount))]
        $currentVerb = $sectionKeys[$currentIndex]
        $currentInfinitive = $section[$currentVerb]["infinitive"]
        [void]$coordinates.Remove($currentIndex)
        $initialCount--

        $currentResponse = Read-Host ("What is the infinitive form of the verb '$currentVerb'")
        $currentCorrectAnswers = $currentInfinitive.Split(", ")
        
        # Check response against correct answer, and generate output
        if ($currentResponse.Trim().ToLower() -in $currentCorrectAnswers) {
            $currentOutput, $currentOutputColour, $correctAnswers = ("Correct - {0}" -f $currentInfinitive), "green", ($correctAnswers + 1)
        } else {
            $currentOutput, $currentOutputColour = ("Wrong - {0}" -f $currentInfinitive), "red"
        }

        Write-Host ("{0} - {1}/{2}" -f $currentOutput, $correctAnswers, $totalQuestions) -ForegroundColor $currentOutputColour
    }
}
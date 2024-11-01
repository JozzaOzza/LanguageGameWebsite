using namespace System.Collections.Generic

# & ".\extras-tester-choice.ps1"
[CmdletBinding()]
param ()  
process {
    # Set path to target files
    $dataPath = "..\..\data"
    $accentsPath = ".\data\accent-marks.json"

    # Get languages
    $languageList = Get-ChildItem -Path ("{0}\*" -f $dataPath) -Name -Include "*-extras.json" -Exclude "template-extras.json" -Recurse -Depth 2
    $languageIterator = 1
    $languageNumberedList = ""
    foreach ($language in $languageList) {
        # Each file name will have the format '<language name>-extras.json'. We want the first part
        $languageNumberedList += ("`n({0}) {1}" -f $languageIterator, $language.Split("-")[0])
        $languageIterator++
    }

    # Get chosen language from user, use response to retrieve file
    $languageResponse = Read-Host ("Pick a language. The options are:{0}`n" -f $languageNumberedList)
    $languageResponseNumber = ([int]$languageResponse) - 1
    $languageName = $languageList[$languageResponseNumber].Split("-")[0]
    $destinationPath = ("{0}\{1}\{2}" -f $dataPath, $languageName, $languageList[$languageResponseNumber])
    $destinationJson = (Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100)["extras"]

    # Get accent marks file
    $accentsJson = Get-Content -Raw $accentsPath | ConvertFrom-Json -AsHashTable -Depth 100
    $accentsString = $accentsJson[$languageName]
    
    # Get categories
    $categoriesList = $destinationJson.Keys
    $categoriesIterator = 1
    $categoriesNumberedList = ""
    
    foreach ($category in $categoriesList) {
        $categoriesNumberedList += ("`n({0}) {1}" -f $categoriesIterator, $category)
        $categoriesIterator++
    }
    
    # Get chosen category from user
    $categoryResponse = Read-Host ("Pick a category. The options are:{0}`n" -f $categoriesNumberedList)
    $categoryResponseNumber = ([int]$categoryResponse) - 1
    $categoryObject = $destinationJson[$categoriesList[$categoryResponseNumber]]
    $wordsList = $categoryObject.Keys

    # Make length of test equal to the amount of words in the chosen category
    $totalPermutations = ($categoryObject.Keys.Count)
    $testLength = $totalPermutations

    $totalQuestions = 0
    $correctAnswers = 0

    # Generate list of 'coordinates' which we can use to randomly search for words
    $wordNumberList = [System.Collections.Generic.List[int]]@()
    for ($wordNumber = 0; $wordNumber -lt $wordsList.Count; $wordNumber++) {
        $wordNumberList.Add($wordNumber)  
    }
    $coordinatesCount = $wordNumberList.Count
    
    while ($totalQuestions -lt $testLength) {
        $totalQuestions++

        # Select randomly from coordinates list, and remove that coordinate
        $currentCoordinateIndex = (Get-Random -Maximum $coordinatesCount)
        $currentCoordinate = $wordNumberList[$currentCoordinateIndex]
        [void]$wordNumberList.remove($currentCoordinate)
        $coordinatesCount--

        # Use coordinates to retrive current word
        $currentWordNumber = $currentCoordinate
        $currentWordAnswer = $categoryObject[$wordsList[$currentWordNumber]]

        # Ask question and collect response
        $currentResponse = Read-Host ("({0}) ({1}) Translate '{2}'. Accent marks: {3}" -f $languageName, $categoriesList[$categoryResponseNumber], $wordsList[$currentWordNumber], $accentsString)

        # Check response against correct answer, and generate output
        if ($currentResponse.Trim().ToLower() -in ($currentWordAnswer.Split(", "))) {
            $currentOutput, $currentOutputColour, $correctAnswers = ("Correct - {0}" -f $currentWordAnswer), "green", ($correctAnswers + 1)
        } else {
            $currentOutput, $currentOutputColour = ("Wrong - {0}" -f $currentWordAnswer), "red"
        }

        Write-Host ("{0} - {1}/{2}" -f $currentOutput, $correctAnswers, $totalQuestions) -ForegroundColor $currentOutputColour
    }
}
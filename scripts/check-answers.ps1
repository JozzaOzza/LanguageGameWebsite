[CmdletBinding()]
param (
   [Parameter()]
   [string]$Languages,
   [Parameter()]
   [string]$Types,
   [Parameter()]
   [string]$Categories
)
begin {
    $languages = ($Languages -eq "*") ? "french, italian, portuguese, spanish" : ($Languages.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $types = ($Types -eq "*") ? "adjectives, adverbs, extras, nouns, verbs" : ($Types.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $categories = ($Categories -eq "*") ? "." : ($Categories.Split(",") | ForEach-Object {$_.Trim()})
}
    
process {
    $language = "spanish"
    $type = "extras"
    $category = "common phrases"

    $correctJson = Get-Content -Raw "..\data\$language\$language-$type.json" | ConvertFrom-Json -AsHashTable -Depth 100
    $correctAnswers = $correctJson[$type]
    $myJson = Get-Content -Raw "..\data\$language\blank\$type.json" | ConvertFrom-Json -AsHashTable -Depth 100
    $myAnswers = $myJson[$type]

    $correctCount = 0

    foreach ($word in $correctAnswers[$category].Keys) {
        $correctAnswer = $correctAnswers[$category][$word]
        $myAnswer = $myAnswers[$category][$word]
        if ($myAnswer -ne $correctAnswer) {
            Write-Host ("Incorrect - Word: {0}, Translation: {1}, Your answer: {2}" -f $word, $correctAnswer, $myAnswer)
        } else {
            Write-Host ("Correct - Word: {0}, Translation: {1}, Your answer: {2}" -f $word, $correctAnswer, $myAnswer)
            $correctCount ++
        }
    }
    Write-Host ("For {0} - {1} - {2}, you scored {3} / {4}" -f $language, $type, $category, $correctCount, $correctAnswers[$category].Keys.count)
}
[CmdletBinding()]
param (
   [Parameter(Mandatory = $true)]
   [string]$Languages,
   [Parameter(Mandatory = $true)]
   [string]$Types,
   [Parameter(Mandatory = $true)]
   [string]$Categories
)
begin {
    $languages = ($Languages -eq "*") ? "french, italian, portuguese, spanish" : ($Languages.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $types = ($Types -eq "*") ? "adjectives, adverbs, extras, nouns, verbs" : ($Types.Split(",") | ForEach-Object {$_.Trim().ToLower()})
    $categories = ($Categories -eq "*") ? "." : ($Categories.Split(",") | ForEach-Object {$_.Trim()})
}
    
process {
    foreach ($language in $languages) {
        foreach ($type in $types) {
            $correctAnswersPath = "..\data\$language\$language-$type.txt"
            $myAnswersPath = "..\data\$language\blank\$type.txt"
        }
    }
    $correctAnswersPath =  "..\data\$language\$language-$template.txt"
    $myAnswersPath = "..\data\$language\blank\$template.txt"
    $category = "Connectives"
    $inCategory = $false
    $iterator = 0
    $questionCount = 0
    $correctCount

    $correctAnswers = Get-Content -Path $correctAnswersPath
    Get-Content -Path $myAnswersPath | ForEach-Object {
        $currentLine = $correctAnswers[$iterator].Trim()
        if ($currentLine -eq "" -and $inCategory -eq $true) {
            break
        }
        if ($inCategory -eq $true) {
            # extract characters in correctAnswer and myAnswer from after the '='
            # split correctAnswer by comma
            # check if correctAnswer contains myAnswer
            Write-Host $currentLine
        }
        if ($currentLine -eq "(Category) $category") {
            $inCategory = $true
            Write-Host $currentLine
        }
        $iterator++
    }
}
[CmdletBinding()]
param (
   [Parameter(Mandatory = $true)]
   [string]$Language,
   [Parameter(Mandatory = $true)]
   [string]$Template,
   [Parameter(Mandatory = $true)]
   [string]$Category
)
begin {
    # $languages = @('french', 'spanish', 'italian', 'portuguese')
    # $templates = @('adjectives', 'adverbs', 'extras', 'nouns', 'verbs')
    # if ($null -ne $Language -or $Language -ne "") {
    #     $languages = $Language.Split(',')
    # }
    # if ($null -ne $template -or $template -ne "") {
    #     $categories = $template.Split(',')
    # }
    $language = $Language
    $template = $Template
    $category = $Category
}
    
process {
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
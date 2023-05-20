# function which takes line and manipulates it

$pattern = '[^ a-zA-Z]'
function EditString {
    param (
        [string]$line
    )
    # Extract the words
    $words = $line -split ' – '

    # Remove slash from Italian side
    $slashIndex = $words[0].IndexOf('/')
    $word = If ($slashIndex -gt -1) {$words[0].Substring(0, $slashIndex)} Else {$words[0]}
    
    # Remove speech marks and 'or' from English side
    $translations = $words[1] -replace $pattern, '' -split ' or '
    $translationsString = $translations -join ', '

    # Build the desired output
    $output = "$translationsString = $word"

    return $output
}

Clear-Content .\text-generator-output.txt
Clear-Content .\output-english.txt
Get-Content '.\block-text.txt' | ForEach-Object {
    $editedLine = EditString $_
    Write-Host $editedLine 
    Add-Content -Path .\text-generator-output.txt -Value $editedLine
    Add-Content -Path .\output-english.txt -Value $editedLine.Substring(0, $editedLine.IndexOf('=')).Trim()
}

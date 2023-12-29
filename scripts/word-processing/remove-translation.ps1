function RemoveTranslation {
    param (
        [string]$line
    )
    # Split by equals sign
    $words = $line -split '='

    # Output trimmed version
    return $words[0].Trim()
}

Get-Content '.\block-text.txt' | ForEach-Object {
    $editedLine = RemoveTranslation $_
    Add-Content -Path .\output-english.txt -Value $editedLine
}
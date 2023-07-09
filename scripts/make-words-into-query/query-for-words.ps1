$queryFile = '.\word-query-text.txt'
$textFile = '.\raw-text.txt'

# remove last line of target file if it's empty
# $queryFileContent = Get-Content $queryFile
# $queryFileContent[0..($queryFileContent.Length - 2)] | Out-File $queryFile -Force

function makeQueryFromLine {
    param (
        [Parameter(Mandatory = $true)]
        [string] $line
    )
    $indexOfEqualSign = $line.IndexOf('=')

    # columns
    $english = $line.Substring(0, $indexOfEqualSign).Trim().ToLower()
    $italian = $line.Substring(($indexOfEqualSign + 1)).Trim().ToLower()
    $topic = 'numbers'
    $alternatives = ''
    $examplePhrase = ''

    # make query string and add to end of target file
    $queryString = "`n('$english', '$italian', '$topic', '$alternatives', '$examplePhrase'),"
    Add-Content -Path $queryFile -Value $queryString -NoNewline
    
}

Get-Content -Path $textFile | ForEach-Object {makeQueryFromLine($_)}
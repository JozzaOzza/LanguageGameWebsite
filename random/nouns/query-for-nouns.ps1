$queryFile = '.\noun-query-text.txt'

# remove last line of target file if it's empty
# $queryFileContent = Get-Content $queryFile
# $queryFileContent[0..($queryFileContent.Length - 2)] | Out-File $queryFile -Force

# base verbs
$english = 'house'
$italian = 'casa'
$topic = 'places'
$alternatives = ''
$examplePhrase = ''

# make query string and add to end of target file
$queryString = "`n('$english', '$italian', '$topic', '$alternatives', '$examplePhrase'),"
Add-Content -Path $queryFile -Value $queryString -NoNewline
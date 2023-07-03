# remove last line of target file if it's empty
# $queryFile = '.\regular-verb-query-text.txt'
# $queryFileContent = Get-Content $queryFile
# $queryFileContent[0..($queryFileContent.Length - 2)] | Out-File $queryFile -Force

# base verbs
$english = 'to call'
$italian = 'chiamare'
$root = $italian.Substring(0, $italian.Length - 3)
$ending = "-$($italian.Substring($italian.Length - 3, 3))"

# regular endings
$iEnding = 'o'
$youSingularEnding = 'i'
$theySingularEnding = 'a'
$weEnding = 'iamo'
$youPluralEnding = 'ate'
$theyPluralEnding = 'ano'

# make query string and add to end of target file
$queryString = "`n('$english', '$italian', '$ending', '$root$iEnding', '$root$youSingularEnding', '$root$theySingularEnding', '$root$weEnding', '$root$youPluralEnding', '$root$theyPluralEnding', 'true'),"
Add-Content -Path $queryFile -Value $queryString
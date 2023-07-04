# remove last line of target file if it's empty
$queryFile = '.\regular-verb-query-text.txt'
# $queryFileContent = Get-Content $queryFile
# $queryFileContent[0..($queryFileContent.Length - 2)] | Out-File $queryFile -Force

# base verbs
$english = 'to leave'
$italian = 'partire'
$root = $italian.Substring(0, $italian.Length - 3)
$ending = "-ire"

# regular endings
$iEnding = 'o'
$youSingularEnding = 'i'
$theySingularEnding = 'e'
$weEnding = 'iamo'
$youPluralEnding = 'ite'
$theyPluralEnding = 'ono'

# make query string and add to end of target file
$queryString = "`n('$english', '$italian', '$ending', '$root$iEnding', '$root$youSingularEnding', '$root$theySingularEnding', '$root$weEnding', '$root$youPluralEnding', '$root$theyPluralEnding', 'True'),"
Add-Content -Path $queryFile -Value $queryString -NoNewline
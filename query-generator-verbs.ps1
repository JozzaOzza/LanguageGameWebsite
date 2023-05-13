# variables
$ending = "-are"
[System.Collections.ArrayList]$inputList= @()
$englishAndItalianString = ""
$isRegular = 1

$verb = @'
To seem / look like = Sembrare
Sembro
Sembri
Sembra
Sembriamo
Sembrate
Sembrano


'@

# convert multi line to array, no whitespace
Write-Host "CONVERTING STRING TO LIST" -ForegroundColor Green
$inputTrimmed = $verb.Trim()
$inputArray = $inputTrimmed -split "`n"
foreach ($line in $inputArray) {
    if ($line.Trim() -ne "") {
        $inputList.Add($line.Trim())
    }
}
Write-Host "Type of List is" $inputList.GetType()
Write-Host "Type of List element is" $inputList[0].GetType()

# generate string for english and italian conjunctives (together)
$conjunctiveIndex = $inputList.Count - 6
$whileCounter = 0

while ($whileCounter -lt $conjunctiveIndex) {
    $englishAndItalianString = $englishAndItalianString + $inputList[$whileCounter]
    $whileCounter++
}
Write-Host "Substring is" $englishAndItalianString

# generate strings for english and italian conjunctives (separate)
$equalSignIndex = $englishAndItalianString.IndexOf("=")
$asteriskIndex = $englishAndItalianString.IndexOf("*")

$english = $englishAndItalianString.Substring(0, $equalSignIndex).Trim()
Write-Host "English is" $english

$italian = $englishAndItalianString.Substring($equalSignIndex + 1).Trim()
$italian = If ($asteriskIndex -ne -1) {
    $italian.Substring(0, $italian.Length - 1)
    $isRegular = 0
} Else {$italian}
Write-Host "Italian is" $italian

# generate query content
$me = $inputList[-6]
$youSingular = $inputList[-5]
$theySingular = $inputList[-4]
$we = $inputList[-3]
$youPlural = $inputList[-2]
$theyPlural = $inputList[-1]

$sqlValues = "'" + $english + "', '" + $italian + "', '" + $ending + "', '" `
     + $me + "', '" + $youSingular + "', '" + $theySingular + "', '" `
     + $we + "', '" + $youPlural + "', '" + $theyPlural + "', " + $isRegular
$sqlStatement = "($sqlValues)"
Write-Host $sqlStatement
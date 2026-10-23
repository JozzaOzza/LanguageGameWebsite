using namespace System.Collections.Generic

# & ".\extras-and-verbs.ps1"
[CmdletBinding()]
param ()  
process {
    $topicNumberedList = @("`n(1) Extras`n(2) Verbs")

    # Get input from user, either verbs or extras
    $topicResponse = Read-Host ("Pick a topic. The options are:{0}`n" -f $topicNumberedList)
    $topicResponseNumber = ([int]$topicResponse) - 1

    if ($topicResponseNumber -eq 0) {
        & ".\extras-tester-choice.ps1"
    }
    else {
        & ".\verb-tester-choice.ps1" -AllConjugations
    }
}
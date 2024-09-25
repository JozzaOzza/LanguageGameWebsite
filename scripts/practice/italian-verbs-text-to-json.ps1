[CmdletBinding()]
param ()  
process {
    $verbs = @("essere", "stare", "avere", "fare", "andare", "amare", "credere", "servire", "finire")
    $conjugations = @("I", "You (singular)", "He/She", "We", "You (plural)", "They (plural)")
    $conjugationObject = @{
        "I"              = $null
        "You (singular)" = $null
        "He/She"         = $null
        "We"             = $null
        "You (plural)"   = $null
        "They (plural)"  = $null
    }
    $tenses = @("indicativo presente", "passato prossimo", "indicativo imperfetto", "passato remoto", "futuro semplice", "condizionale presente", "congiuntivo presente", "congiuntivo imperfetto")

    $sourcePath = ".\copied-from-docs.txt"
    $destinationPath = ".\correct-answers.json" 
    $destinationJson = Get-Content -Raw $destinationPath | ConvertFrom-Json -AsHashTable -Depth 100

    $tense = $null
    $verb = $null
    $conjugateNumber = 0

    Get-Content -Path $sourcePath | ForEach-Object {
        if ($_.Trim() -eq "") {
            Write-Host "empty"
        }
        elseif ($_.StartsWith('(tense)')) {
            Write-Host "tense"
            $tense = $_.Split(')')[1].Trim().ToLower()
            # $destinationJson[$tense] = @{}
        }
        elseif ($verbs -contains $_.Trim().ToLower()) {
            Write-Host "verb"
            $verb = $_.Trim().ToLower()
            # $destinationJson[$tense][$verb] = @{}
        }
        else {
            Write-Host "conjugate"
            $conjugation = $conjugations[$conjugateNumber]
            $destinationJson[$tense][$verb][$conjugation] = $_.Trim().ToLower()
            $conjugateNumber = ($conjugateNumber -eq 5) ? 0 : $conjugateNumber + 1
        }
    }

    $destinationJson | ConvertTo-Json -depth 100 | Out-File $destinationPath
}
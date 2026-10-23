[CmdletBinding()]
param (
   [Parameter()]
   [string]$Language,
   [Parameter()]
   [string]$Template
)
begin {
    $languages = @('french', 'spanish', 'italian', 'portuguese')
    $templates = @('adjectives', 'adverbs', 'extras', 'nouns', 'verbs')
    # if ($null -ne $Language -or $Language -ne "") {
    #     $languages = $Language.Split(',')
    # }
    # if ($null -ne $template -or $template -ne "") {
    #     $categories = $template.Split(',')
    # }
}
    
process {
    foreach ($language in $languages) {
        foreach ($template in $templates) {
            $language = $language.Trim()
            $template = $template.Trim()
            $originPath = "..\data\$language\$language-$template.txt"
            $destinationPath = "..\data\$language\blank\$template.txt"
            
            Clear-Content -Path $destinationPath
            Get-Content -Path $originPath | ForEach-Object {
                if ($_.Contains("=")) {
                    $indexOfEqualSign = $_.IndexOf("=")
                    Add-Content -Path $destinationPath -Value $_.Substring(0, $indexOfEqualSign + 1).Trim()
                }
                else {
                    Add-Content -Path $destinationPath -Value $_.Trim()
                }
            }
        }
    }
}
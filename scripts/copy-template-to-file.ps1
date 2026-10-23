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
    if ($null -ne $Language) {
        $languages = $Language.Split(',')
    }
    if ($null -ne $Template) {
        $templates = $Template.Split(',')
    }
}
    
process {
    foreach ($language in $languages) {
        foreach ($template in $templates) {
            $language = $language.Trim()
            $template = $template.Trim()
            Clear-Content -Path "..\data\$language\$language-$template.txt"
            
            Get-Content -Path "..\data\templates\template-$template.txt" | ForEach-Object {
                if ($_.StartsWith('(Language)')) {
                    Add-Content -Path "..\data\$language\$language-$template.txt" -Value "(Language) $language"
                }
                elseif ($_.StartsWith('(Table)')) {
                    Add-Content -Path "..\data\$language\$language-$template.txt" -Value "$_"
                }
                elseif ($_.StartsWith('(Category)')) {
                    Add-Content -Path "..\data\$language\$language-$template.txt" -Value "$_"
                }
                elseif ($_.Trim() -ne "") {
                    Add-Content -Path "..\data\$language\$language-$template.txt" -Value "$($_.ToLower().Trim()) = "
                }
                else {
                    Add-Content -Path "..\data\$language\$language-$template.txt" -Value "$_"
                }
            }
        }
    }
}
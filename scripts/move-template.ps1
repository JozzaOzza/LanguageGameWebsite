[CmdletBinding()]
param (
        
)
# Move template files to the corresponding file for each language
begin {
    $languages = @('french', 'spanish', 'italian', 'portuguese')
    $templates = @('adjectives', 'adverbs', 'extras', 'nouns', 'verbs')
}
    
process {
    foreach ($language in $languages) {
        foreach ($template in $templates) {
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
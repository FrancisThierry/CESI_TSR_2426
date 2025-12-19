. ./rss_function.ps1
. ./sqlite_function.ps1
# $url = "https://www.lemonde.fr/rss/une.xml"
# $rssPath = "https://www.lemonde.fr/rss/une.xml"

$db = "C:\database\veille.db"

# Get-Rss -Url $rssPath | Format-Table -AutoSize
Install-SqliteModule
# Get-ListRssFromDatabase -db  "C:\database\veille.db"

Add-Feed -db $db -titre "Titre Test" -datePub (Get-Date) -motsCles "test, rss" -lien "https://www.lemonde.fr/rss/une.xml"
Get-ListRssFromDatabase -db $db
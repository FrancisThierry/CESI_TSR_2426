. ./rss_function.ps1
# $url = "https://www.lemonde.fr/rss/une.xml"
$rssPath = "https://www.lemonde.fr/rss/une.xml"

Get-Rss -Url $rssPath
. ./rss_function.ps1
. ./ppt_fonction.ps1

$presentation = Add-pptObject
$listRss = Get-Rss -Url "https://www.lemonde.fr/rss/une.xml"

$i = 1
foreach ($rss in $listRss) {
    $slide = Add-Slide -presentation $presentation -slideIndex $i -layoutType 1
    Add-SlideItemText -slide $slide -itemIndex 1 -text $rss.Titre.ToString()

    # $slide = Add-Slide -presentation $presentation -slideIndex $i -layoutType 1
    # Add-SlideItemText -slide $slide -itemIndex 2 -text $rss.Description.ToString()

    $i++
    
}
$uid = [guid]::NewGuid().ToString()
Save-Ppt -presentation $presentation -path "C:\Temp\RssFeeds"+$uid+".pptx"
Write-Host "Le PowerPoint a été généré avec succès !" -ForegroundColor Green






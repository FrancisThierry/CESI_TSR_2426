$reponse = Invoke-WebRequest -Uri "http://www.google.fr" -Method GET -UseBasicParsing

Write-Host $reponse.StatusCode
Write-Host $reponse.StatusDescription   
Write-Host $reponse.Content
if ($reponse.StatusCode -eq 200) {
    Write-Host "Le site est accessible."
} else {
    Write-Host "Le site n'est pas accessible. Code d'erreur : $($reponse.StatusCode)"
}


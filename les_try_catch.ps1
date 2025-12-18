try {
    $nombre = Read-Host "Entrez un nombre "
    $nombre = [int]$nombre
    Write-Host "Le nombre est : $nombre"
}
catch {
    Write-Host "Erreur : Veuillez entrer un nombre valide !" -ForegroundColor Red
}

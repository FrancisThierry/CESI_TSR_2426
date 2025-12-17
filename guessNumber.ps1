# déclarer une varaible aléatoire entre 1 et 100
$nombreSecret = Get-Random -Minimum 1 -Maximum 100
$saisie = Read-Host "Entrez votre proposition "
Write-Host "Votre proposition est : $saisie"

if($saisie -eq $nombreSecret) {
    Write-Host "Bravo ! Vous avez trouvé le nombre secret : $nombreSecret" -ForegroundColor Green
} elseif ($saisie -lt $nombreSecret) {
    Write-Host "           Plus grand !" -ForegroundColor Yellow
} else {
    Write-Host "           Plus petit !" -ForegroundColor Yellow
}

Write-Host "Le nombre secret était : $nombreSecret"

# Modifier le programme pour qu'il boucle jusqu'à ce que l'utilisateur trouve le nombre secreet ou tape "exit" pour quitter
# Modifier à nouveau pour que le programme compte le nombre de tentatives et l'affiche à la fin. Tentatives maximum : 10

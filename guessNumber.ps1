# Générer un nombre entre 1 et 100
# Déclarer et initialiser les variables
$nombreSecret = Get-Random -Minimum 1 -Maximum 101 # 101 pour inclure 100
$nombreTentatives = 0
$maxTentatives = 10
$saisie = ""
# Message de bienvenue
Write-Host "--- Jeu du Nombre Secret (Tapez 'exit' pour quitter) ---" -ForegroundColor Cyan

# Boucle principale
# On utilise les opérateurs logiques pour contrôler la boucle
# en PowerShell : !and (ET), -or (OU), -not (NON)
while ($saisie -ne $nombreSecret -and $nombreTentatives -lt $maxTentatives) {
    # la saisie de l'utilisateur
    $saisie = Read-Host "Tentative $($nombreTentatives + 1)/$maxTentatives - Entrez votre proposition"

    # Vérifier si l'utilisateur veut quitter
    if ($saisie -eq "exit") {
        Write-Host "Abandon de la partie." -ForegroundColor DarkYellow
        break
    }

    # Incrémenter le compteur
    $nombreTentatives++

    # Comparaison 
    if ($saisie -eq $nombreSecret) {
        Write-Host "Bravo ! Vous avez trouvé en $nombreTentatives tentatives." -ForegroundColor Green
    } 
    elseif ($saisie -lt $nombreSecret) {
        Write-Host "C'est PLUS GRAND !" -ForegroundColor Yellow
    } 
    else {
        Write-Host "C'est PLUS PETIT !" -ForegroundColor Yellow
    }
}

# Message de fin si non trouvé
if ($saisie -ne $nombreSecret -and $saisie -ne "exit") {
    Write-Host "Dommage ! Vous avez atteint le maximum de tentatives ($maxTentatives)." -ForegroundColor Red
    Write-Host "Le nombre secret était : $nombreSecret"
}
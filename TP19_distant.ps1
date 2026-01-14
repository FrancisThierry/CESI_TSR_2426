# ### **TP 19 : Statistiques de création de comptes**

# * **Objectif :** Suivre l'évolution récente de l'annuaire.
# * **Énoncé :** Affichez tous les comptes utilisateurs créés au cours des 30 derniers jours. Affichez la date de création et la personne qui a créé le compte (si l'attribut est renseigné).
# * **Indices :** `Get-ADUser`, propriété `whenCreated`, calcul de date avec `(Get-Date).AddDays(-30)
# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Calcul de la date il y a 30 jours
    $dateThreshold = (Get-Date).AddDays(-30)

    # Récupération des utilisateurs créés dans les 30 derniers jours
    $recentUsers = Get-ADUser -Filter * -Properties whenCreated | 
        Where-Object { $_.whenCreated -ge $dateThreshold }

    # Affichage des résultats
    foreach ($user in $recentUsers) {
        Write-Host "Utilisateur créé: $($user.SamAccountName) - Date de création: $($user.whenCreated) Créé par: $($user.CreatedBy)"
    }

    # si pas d'utilisateur créé récemment
    if ($recentUsers.Count -eq 0) {
        Write-Host "Aucun compte utilisateur n'a été créé au cours des 30 derniers jours." -ForegroundColor Green     
    }
}
# ### **TP 15 : Audit du verrouillage des comptes**

# * **Objectif :** Identifier les utilisateurs actuellement bloqués suite à des erreurs de mot de passe.
# * **Énoncé :** Écrivez un script qui recherche tous les utilisateurs dont le compte est actuellement verrouillé (`LockedOut`). Affichez l'heure du verrouillage.
# * **Indices :** `Search-ADAccount -LockedOut`, `Select-Object Name, LockedOutPropertyValue`.
# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Récupération des utilisateurs dont le compte est verrouillé
    $lockedOutUsers = Search-ADAccount -LockedOut | Select-Object Name, LockedOutPropertyValue
    
    # Affichage des résultats
    foreach ($user in $lockedOutUsers) {
        Write-Host "Utilisateur: $($user.Name), Verrouillé depuis: $($user.LockedOutPropertyValue)"
    }

    # si pas de compte verrouillé
    if ($lockedOutUsers.Count -eq 0) {
        Write-Host "Aucun compte utilisateur n'est actuellement verrouillé." -ForegroundColor Green     
    }

}
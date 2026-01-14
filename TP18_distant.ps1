# ### **TP 18 : Identification des comptes sans protection contre la suppression**

# * **Objectif :** Prévenir les erreurs de manipulation administratives.
# * **Énoncé :** Trouvez tous les objets de type "Utilisateur" qui ne bénéficient pas de la protection contre la suppression accidentelle.
# * **Indices :** `Get-ADUser -Filter * -Properties ProtectedFromAccidentalDeletion`, filtre sur la valeur `$false`.

# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Récupération des utilisateurs sans protection contre la suppression accidentelle
    $usersWithoutProtection = Get-ADUser -Filter * -Properties ProtectedFromAccidentalDeletion | 
        Where-Object { $_.ProtectedFromAccidentalDeletion -eq $false }
    
    # Affichage des résultats
    foreach ($user in $usersWithoutProtection) {
        Write-Host "Utilisateur sans protection contre la suppression: $($user.SamAccountName) - $($user.Name)"
    }

    # si pas d'utilisateur sans protection
    if ($usersWithoutProtection.Count -eq 0) {
        Write-Host "Tous les utilisateurs bénéficient de la protection contre la suppression accidentelle." -ForegroundColor Green     
    }
        
    
}
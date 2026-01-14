
# ### **TP 17 : Vérification de l'appartenance aux groupes d'un utilisateur**

# * **Objectif :** Auditer les droits d'un utilisateur spécifique.
# * **Énoncé :** Demandez (via une variable) le nom d'un utilisateur et listez tous les groupes de sécurité dont il est membre (groupes directs uniquement).
# * **Indices :** `Get-ADPrincipalGroupMembership`, `Select-Object Name`.

# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Demande du nom d'utilisateur
    $username = Read-Host "Entrez le SamAccountName de l'utilisateur"

    # Récupération des groupes de sécurité dont l'utilisateur est membre
    $groups = Get-ADPrincipalGroupMembership -Identity $username | Select-Object Name

    # Affichage des résultats
    foreach ($group in $groups) {
        Write-Host "Nom du groupe: $($group.Name)"
    }

}

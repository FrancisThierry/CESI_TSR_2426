### **TP 14 : Analyse de l'arborescence des Unités d'Organisation (OU)**

# * **Objectif :** Visualiser la structure de l'annuaire.
# * **Énoncé :** Listez toutes les Unités d'Organisation présentes dans le domaine. Pour chaque OU, affichez son nom et le chemin complet (`DistinguishedName`).
# * **Indices :** `Get-ADOrganizationalUnit -Filter *`, `Select-Object Name, DistinguishedName`.


# Commmencer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Récupération des Unités d'Organisation
    $ous = Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
    
    # Affichage des résultats
    foreach ($ou in $ous) {
        Write-Host "Nom de l'OU: $($ou.Name), Chemin complet: $($ou.DistinguishedName)"
    }

        
}
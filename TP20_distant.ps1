# ### **TP 20 : Vérification de l'état des contrôleurs de domaine**

# * **Objectif :** S'assurer de la santé de l'infrastructure AD.
# * **Énoncé :** Récupérez la liste de tous les contrôleurs de domaine de la forêt actuelle et affichez leur adresse IP ainsi que leur mode de fonctionnement (Global Catalog ou non).
# * **Indices :** `Get-ADDomainController -Filter *`, `Select-Object Name, IPv4Address, IsGlobalCatalog`.

# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Récupération des contrôleurs de domaine
    $domainControllers = Get-ADDomainController -Filter * | Select-Object Name, IPv4Address, IsGlobalCatalog
    
    # Affichage des résultats
    foreach ($dc in $domainControllers) {
        Write-Host "Nom: $($dc.Name), IP: $($dc.IPv4Address), Global Catalog: $($dc.IsGlobalCatalog)"
    }
}

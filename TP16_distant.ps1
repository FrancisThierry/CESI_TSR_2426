# ### **TP 16 : Rapport sur les ordinateurs du domaine**

# * **Objectif :** Inventorier le parc informatique enregistré dans l'AD.
# * **Énoncé :** Listez tous les ordinateurs du domaine. Affichez leur nom, leur système d'exploitation et la version de l'OS. Triez le résultat par système d'exploitation.
# * **Indices :** `Get-ADComputer -Filter * -Properties OperatingSystem`, `Sort-Object OperatingSystem`.

# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    # Récupération des ordinateurs du domaine avec leurs propriétés
    $computers = Get-ADComputer -Filter * -Properties OperatingSystem, OperatingSystemVersion
    
    # Tri par système d'exploitation
    $sortedComputers = $computers | Sort-Object OperatingSystem
    
    # Affichage des résultats
    foreach ($computer in $sortedComputers) {
        Write-Host "Nom: $($computer.Name), OS: $($computer.OperatingSystem), Version: $($computer.OperatingSystemVersion)"
    }


        
    
}
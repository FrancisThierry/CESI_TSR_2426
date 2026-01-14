# ### **TP 11 : Audit des comptes utilisateurs inactifs**

# * **Objectif :** Identifier les comptes qui n'ont pas été utilisés pour renforcer la sécurité.
# * **Énoncé :** Listez tous les utilisateurs du domaine qui ne se sont pas connectés depuis plus de 90 jours. Affichez leur nom (`Name`), leur `SamAccountName` et la date de leur dernière connexion.
# * **Indices :** `Get-ADUser`, paramètre `-Filter`, propriété `LastLogonDate`.
# Contenu de TP1_distant.ps1
# ### **TP 11 : Audit des comptes utilisateurs inactifs**
## Pour invoker ce script
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    
    # Vérifier si le module AD est présent
    if (Get-Module -ListAvailable ActiveDirectory) {
        Import-Module ActiveDirectory
        
        # Calcul de la date de référence (Aujourd'hui - 90 jours)
        $cutoffDate = (Get-Date).AddDays(-90)
        
        Write-Host "Recherche des comptes inactifs depuis le : $($cutoffDate.ToShortDateString())" -ForegroundColor Yellow
        
        # Récupération des utilisateurs
        Get-ADUser -Filter 'Enabled -eq $true' -Properties LastLogonDate |
            Where-Object { ($null -eq $_.LastLogonDate) -or ($_.LastLogonDate -lt $cutoffDate) } |
            Select-Object Name, SamAccountName, LastLogonDate |
            Format-Table -AutoSize
    } else {
        Write-Error "Le module Active Directory n'est pas installé sur SRV-AD."
    }
}
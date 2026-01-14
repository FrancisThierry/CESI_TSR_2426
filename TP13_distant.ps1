# ### **TP 13 : Recherche de comptes "sensibles"**

# * **Objectif :** Isoler les comptes dont le mot de passe n'expire jamais dans l'AD.
# * **Énoncé :** Identifiez tous les utilisateurs de l'AD ayant l'option "Le mot de passe n'expire jamais" activée. Exportez le résultat dans un fichier CSV nommé `Audit_Passwords.csv`.
# * **Indices :** `Get-ADUser -Filter 'PasswordNeverExpires -eq $true'`, `Export-Csv`.

# Exemple pour invoker un script distant
# Commmnecer par appeler la machine distante avec les bonnes credentials
## Invoke-Command -HostName "DJ4JN202-AUT-1.numerilab-cesi.fr" -UserName "Administrateur" -FilePath "./Correction_TD_Distant/TP11_distant.ps1"

Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
# dans scriptBlock ajouter votre code
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    $outputFile = "C:\Audit_Passwords.csv"
    
    # Récupération des utilisateurs avec mot de passe n'expirant jamais
    $users = Get-ADUser -Filter 'PasswordNeverExpires -eq $true' -Properties SamAccountName, Name, PasswordNeverExpires
    
    # Sélection des propriétés à exporter
    $users | Select-Object SamAccountName, Name, PasswordNeverExpires | 
        Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8
    
    Write-Host "Audit des mots de passe exporté vers $outputFile" -ForegroundColor Green
        
    
}
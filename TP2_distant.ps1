### **TP 2 : Audit de sécurité des comptes locaux**

#* **Objectif :** Identifier les failles de sécurité potentielles sur les mots de passe.
#* **Énoncé :** Affichez la liste de tous les utilisateurs locaux qui possèdent la caractéristique "Le mot de passe n'expire jamais". Le rapport doit afficher le nom de l'utilisateur et la date de sa dernière connexion.
#* **Indices :** `Get-LocalUser`, filtre sur `PasswordNeverExpires`, `LastLogon`.

Get-LocalUser | Where-Object { $null -eq $_.PasswordNeverExpires } | 
    Select-Object Name, LastLogon, PasswordNeverExpires | 
    Format-Table -AutoSize

# On récupère les utilisateurs via ADSI
$utilisateurs = [ADSI]"WinNT://$env:COMPUTERNAME"
$utilisateurs.Children | Where-Object { $_.SchemaClassName -eq 'user' } | Select-Object @{N="Utilisateur"; E={$_.Name[0]}}, @{N="PasswordNeverExpires"; E={
    # On vérifie le bit 0x10000 (ADS_UF_DONT_EXPIRE_PASSWD)
    if ($_.UserFlags[0] -band 0x10000) { $true } else { $false }
}} | Format-Table -AutoSize
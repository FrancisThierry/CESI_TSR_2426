# ### **TP 12 : Cartographie des groupes d'administration**

# * **Objectif :** Vérifier qui possède des privilèges élevés sur le domaine.
# * **Énoncé :** Affichez la liste des membres du groupe "Domain Admins". Le script doit retourner uniquement le nom d'affichage (`DisplayName`) et l'état du compte (activé ou désactivé).
# * **Indices :** `Get-ADGroupMember`, `-Identity "Domain Admins"`, `Get-ADUser` pour récupérer les détails de chaque membre.



Write-Host "Connexion en cours vers SRV-AD.tp.local pour audit AD..." -ForegroundColor Cyan

# Get-Credential ouvrira une fenêtre pour taper "Administrateur" et son mot de passe.
Invoke-Command -ComputerName "SRV-AD.tp.local" -Credential (Get-Credential) -ScriptBlock {
    $groupName = "Admins du domaine"
    $members = Get-ADGroupMember -Identity $groupName
    foreach ($member in $members) {
        $user = Get-ADUser -Identity $member.SamAccountName -Properties DisplayName, Enabled
        Write-Host "Nom d'affichage: $($user.DisplayName), Compte activé: $($user.Enabled)" 
    }
    
    
}
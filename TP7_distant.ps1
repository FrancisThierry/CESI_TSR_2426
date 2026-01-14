### **TP 7 : Historique des mises à jour système**

# * **Objectif :** Vérifier que le serveur est à jour.
# * **Énoncé :** Listez les 10 dernières mises à jour (Hotfix) installées sur la machine. Affichez l'identifiant de la mise à jour (HotFixID), la description et la date d'installation.
# * **Indices :** `Get-HotFix`, `Sort-Object InstalledOn`, `Select-Object -First 10`.

Get-HotFix | 
    Sort-Object InstalledOn -Descending | 
    Select-Object -First 10 -Property HotFixID, Description, InstalledOn | 
    Format-Table -AutoSize
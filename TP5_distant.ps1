### **TP 5 : Nettoyage automatique des journaux**

#* **Objectif :** Gérer l'espace disque en ciblant les vieux fichiers inutiles.
#* **Énoncé :** Parcourez le dossier `C:\Windows\Logs`. Pour chaque fichier créé il y a plus de 30 jours, affichez son nom et sa taille. Ajoutez une commande (en mode simulation `-WhatIf`) pour les supprimer.
#* **Indices :** `Get-ChildItem -Recurse`, `Where-Object`, `(Get-Date).AddDays(-30)`, `Remove-Item`.
$logPath = "C:\Windows\Logs"
Get-ChildItem -Path $logPath -Recurse | 
    Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) } | 
    Select-Object Name, Length, CreationTime | 
    Format-Table -AutoSize
# Suppression des fichiers (mode simulation)
Get-ChildItem -Path $logPath -Recurse | 
    Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) } | 
    Remove-Item -WhatIf 
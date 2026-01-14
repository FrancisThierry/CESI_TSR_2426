
### **TP 6 : Surveillance des services critiques**

# * **Objectif :** Vérifier la cohérence entre la configuration et l'état réel.
# * **Énoncé :** Trouvez tous les services dont le nom commence par "Win" (ex: WinRM, Windows Update). Affichez uniquement ceux qui sont configurés en démarrage "Automatique" mais qui ne sont pas en cours d'exécution.
# * **Indices :** `Get-Service`, filtres combinés sur `StartType` et `Status`.

Get-Service -ErrorAction SilentlyContinue | 
    Where-Object { $_.Name -like "Win*" -and $_.StartType -eq 'Automatic' -and $_.Status -ne 'Running' } | 
    Select-Object Name, StartType, Status | 
    Format-Table -AutoSize


Get-Service -ErrorAction SilentlyContinue | 
    Where-Object { $_.Name -like "Win*" -and $_.StartType -eq 'Automatic' -and $_.Status -eq 'Running' } | 
    Select-Object Name, StartType, Status | 
    Format-Table -AutoSize    
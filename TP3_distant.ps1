### **TP 3 : Analyse des performances (Top Processus)**

#* **Objectif :** Identifier les "consommateurs" de ressources en temps réel.
#* **Énoncé :** Créez un script qui identifie les 5 processus utilisant le plus de mémoire vive (RAM) et les 5 utilisant le plus de temps processeur (CPU). Affichez leur nom et leur identifiant (Id).
#* **Indices :** `Get-Process`, `Sort-Object -Descending`, `Select-Object -First 5`.

# 1. Top 5 par utilisation Mémoire (RAM)
Write-Host "--- TOP 5 MÉMOIRE (RAM) ---" -ForegroundColor Cyan
Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 5 -Property Name, Id, WS

# 2. Top 5 par utilisation Processeur (CPU)
Write-Host "`n--- TOP 5 CPU ---" -ForegroundColor Yellow
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 5 -Property Name, Id, CPU
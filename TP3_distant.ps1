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
# 3. Top 5 par utilisation Processeur (CPU) pourcentage
Write-Host "`n--- TOP 5 CPU (%) ---" -ForegroundColor Yellow
Get-Process | ForEach-Object {
    $cpuPercent = if ($_.CPU -and $($_.StartTime)) {
        $uptime = (Get-Date) - $_.StartTime
        if ($uptime.TotalSeconds -gt 0) {
            [math]::Round(($_.CPU / $uptime.TotalSeconds) * 100, 2)
        } else {
            0
        }
    } else {
        0
    }
    [PSCustomObject]@{
        Name = $_.Name
        Id = $_.Id
        CPUPercent = $cpuPercent
    }
} | Sort-Object -Property CPUPercent -Descending | Select-Object -First 5 -Property Name, Id, CPUPercent


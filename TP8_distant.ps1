### **TP 8 : Diagnostic matériel rapide (BIOS et Uptime)**

# * **Objectif :** Obtenir les informations d'identité du serveur.
# * **Énoncé :** Récupérez via les classes CIM/WMI le numéro de série de la machine (Tag) et la date du dernier redémarrage. Calculez depuis combien de temps le serveur est allumé.
# * **Indices :** `Get-CimInstance -ClassName Win32_BIOS`, `Win32_OperatingSystem`.
# Récupération du numéro de série (Tag) via Win32_BIOS
$bios = Get-CimInstance -ClassName Win32_BIOS
$serialNumber = $bios.SerialNumber
Write-Host "Numéro de série (Tag) du serveur : $serialNumber" -ForegroundColor Green    
# Récupération de la date du dernier redémarrage via Win32_OperatingSystem
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$lastBootDate = $os.LastBootUpTime
Write-Host "Dernier redémarrage : $lastBootDate" -ForegroundColor Green
# Calcul de l'uptime
$uptime = (Get-Date) - $lastBootDate
$days = $uptime.Days
$hours = $uptime.Hours
$minutes = $uptime.Minutes
Write-Host "Le serveur est allumé depuis : $days jours, $hours heures, $minutes minutes." -ForegroundColor Green
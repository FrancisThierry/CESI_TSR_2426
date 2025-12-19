using module ".\StatModule\StatModule.psm1"

$monObjet = [ComputerStats]::new($env:COMPUTERNAME)
Write-Host "Le PC $($monObjet.Ordinateur) est à $($monObjet.Charge_CPU) de charge." -ForegroundColor Green

Write-Host "La mémoire utilisée est de $($monObjet.RAM_Libre_Pct) sur un total de 100%." -ForegroundColor Green

param (
    [string]$ComputerName
)

begin {
    # import des fonctions
    . .\SanteFonction.ps1

}

process {
    # test de la fonction
    # $drivers = Get-StorageDriver
    # Write-Host "État SMART du disque : $drivers"
    # $ram = Get-Ram
    # Write-Host "Pourcentage de RAM libre : $ram %"

    # $cpu = Get-CPU
    # Write-Host "Pourcentage d'utilisation CPU : $cpu %"

    # $statusBattery = Get-BatteryStatus
    # Write-Host "Statut de la batterie : $statusBattery"

    Get-DashBoard | Format-Table -AutoSize
    
}

end {
        
}
# Utilisation de la classe MSStorageDriver_FailurePredictStatus

function Get-StorageDriver {
    $SmartData = Get-CimInstance -Namespace "root\wmi" -ClassName MSStorageDriver_FailurePredictStatus -ErrorAction SilentlyContinue
    $SanteDisque = if ($SmartData.PredictFailure -eq $true) { "CRITIQUE" } else { "Sain" }

    return $SanteDisque
}

function Get-Ram {
    $OS = Get-CimInstance -ClassName Win32_OperatingSystem
    $RamLibrePct = [math]::Round(($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100, 2)
    return $RamLibrePct
}
function Get-CPU {
    return  (Get-CimInstance -ClassName Win32_Processor).LoadPercentage   

}

function Get-BatteryStatus {
    $Battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
    $StatutBatterie = if ($null -ne $Battery) { "$($Battery.EstimatedChargeRemaining)%" } else { "Fixe" }
    return $StatutBatterie
}

function Get-DashBoard {
    [CmdletBinding()]
    param(
        # On permet à l'argument de venir du pipeline
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    process {
        foreach ($Computer in $ComputerName) {
            # On génère l'objet pour chaque ordinateur reçu
            [PSCustomObject]@{
                Ordinateur      = $Computer.ToUpper()
                Sante_Disque    = Get-StorageDriver # Note : Tes fonctions devraient idéalement prendre -ComputerName
                RAM_Libre_Pct   = "$(Get-Ram) %"
                Charge_CPU      = "$(Get-CPU) %"
                Statut_Batterie = Get-BatteryStatus
            }
        }
    }
}
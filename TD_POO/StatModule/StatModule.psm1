class ComputerStats {
    # --- Propriétés ---
    [string]$Ordinateur
    [string]$Sante_Disque
    [string]$RAM_Libre_Pct
    [string]$Charge_CPU
    [string]$Statut_Batterie
    [datetime]$DerniereMaj

    # --- Constructeur ---
    ComputerStats([string]$Name) {
        $this.Ordinateur = $Name.ToUpper()
        $this.Refresh()
    }

    # --- Méthodes Publiques ---
    [void] Refresh() {
        $this.Sante_Disque    = $this._GetStorageStatus()
        $this.RAM_Libre_Pct   = "$($this._GetRamUsage()) %"
        $this.Charge_CPU      = "$($this._GetCpuLoad()) %"
        $this.Statut_Batterie = $this._GetBattery()
        $this.DerniereMaj     = Get-Date
    }

    # --- Méthodes Privées (Logique interne) ---

    hidden [string] _GetStorageStatus() {
        try {
            $SmartData = Get-CimInstance -Namespace "root\wmi" -ClassName MSStorageDriver_FailurePredictStatus -ErrorAction Stop
            # Correction syntaxe : if/else standard
            if ($SmartData.PredictFailure -eq $true) { 
                return "CRITIQUE" 
            } else { 
                return "Sain" 
            }
        } catch {
            return "Indisponible"
        }
    }

    hidden [double] _GetRamUsage() {
        try {
            $OS = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
            $pct = ($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100
            return [math]::Round($pct, 2)
        } catch {
            return 0.0
        }
    }

    hidden [int] _GetCpuLoad() {
        try {
            $load = (Get-CimInstance -ClassName Win32_Processor -ErrorAction Stop).LoadPercentage
            return ($load | Select-Object -First 1)
        } catch {
            return 0
        }
    }

    hidden [string] _GetBattery() {
        try {
            $Battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
            # Correction syntaxe : if/else standard
            if ($null -eq $Battery) { 
                return "Secteur (Fixe)" 
            } else {
                return "$($Battery.EstimatedChargeRemaining)%"
            }
        } catch {
            return "Inconnu"
        }
    }
}

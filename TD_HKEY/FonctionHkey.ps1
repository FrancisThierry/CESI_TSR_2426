function Get-ComputerNameWithHkey {
    
    # A partir de HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName
    $ComputerName = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" -Name "ComputerName" | Select-Object -ExpandProperty ComputerName
    return $ComputerName
}

function Set-ToggleDarkMode {

    begin {
        $pathModeSombre = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

        $currentDarkMOde = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" | Select-Object -ExpandProperty AppsUseLightTheme
    }
    process {
        if ($currentDarkMOde -eq 0) {
            Set-RegistryKey -Path $pathModeSombre -ValueName "AppsUseLightTheme" -Value 1 -Type Dword

        }
        else {
            Set-RegistryKey -Path $pathModeSombre -ValueName "AppsUseLightTheme" -Value 0 -Type Dword
        }

    }

}

function Set-RegistryKey {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$ValueName,

        [Parameter(Mandatory = $true)]
        $Value,

        [ValidateSet("String", "Dword", "Qword", "Binary", "MultiString", "ExpandString")]
        [string]$Type = "String"
    )

    process {
        try {
            # 1. Créer le chemin si nécessaire
            if (-not (Test-Path $Path)) {
                $null = New-Item -Path $Path -Force
                Write-Verbose "Création du dossier de registre : $Path"
            }

            # 2. Créer ou modifier la valeur
            $null = New-ItemProperty -Path $Path `
                -Name $ValueName `
                -Value $Value `
                -PropertyType $Type `
                -Force
            
            Write-Host "Succès : [$Path] $ValueName = $Value ($Type)" -ForegroundColor Green
        }
        catch {
            Write-Error "Impossible d'écrire dans le registre : $($_.Exception.Message)"
        }
    }
}
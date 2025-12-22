<#
.SYNOPSIS
Ajoute une tâche planifiée de manière robuste.

.DESCRIPTION
Crée une tâche planifiée pour exécuter un script PowerShell à 08h00 chaque jour.

.EXAMPLE
Add-Scheduller -scriptPath "C:\Scripts\MonScript.ps1" -taskName "MaTache"
#>
function Add-Scheduller {
    param (
        [Parameter(Mandatory = $true)] 
        [string]$scriptPath,

        [Parameter(Mandatory = $true)] 
        [string]$taskName
    )

    begin {
        # Vérifie si le script existe réellement avant de continuer
        if (-Not (Test-Path $scriptPath)) {
            throw "Erreur : Le script spécifié n'existe pas au chemin : $scriptPath"
        }
    }

    process {
        try {
            # 1. Définition du déclencheur (Quotidien à 08:00)
            $trigger = New-ScheduledTaskTrigger -Daily -At 08:00

            # 2. Préparation des arguments (CORRECTION : Tout doit être dans une seule chaîne)
            # On utilise -NoProfile pour la rapidité et -ExecutionPolicy Bypass pour éviter les blocages
            $taskArguments = "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`" "
            
            # 3. Définition de l'action
            $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $taskArguments

            # 4. Enregistrement de la tâche
            # Le paramètre -Force écrase la tâche si elle existe déjà (évite les erreurs)
            Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Force | Out-Null
            
            Write-Host "Succès : La tâche '$taskName' a été créée." -ForegroundColor Green
        }
        catch {
            Write-Error "Impossible de créer la tâche : $($_.Exception.Message)"
        }
    }

    end {
        # Vérification finale : affiche les détails de la tâche créée
        if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
            Get-ScheduledTask -TaskName $taskName
        }
    }
}
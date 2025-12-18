begin {

    function Get-UserInCsv {
        param (
            [string]$csvPath
        ) 
        if (Test-Path $csvPath) {
            $users = Import-Csv -Path $csvPath
            return @($users)
        }
        else {
            Write-Error "Le fichier $csvPath n'existe pas."
            return @()
        }
    }

    function Get-UserToAdd {
        [CmdletBinding()]
        param (
            [string]$csvPath = "./utilisateurs.csv"
            
        )
        
        begin {
            
        }
        
        process {
            $allUsers = Get-UserInCsv -csvPath $csvPath
            
            if ($null -eq $allUsers -or $allUsers.Count -eq 0) {
                Write-Warning "Aucun utilisateur trouvé dans le CSV. Vérifiez l'encodage et le chemin."
                return
            }
        }
        
        end {
            
        }
    }

    # Initialisation si nécessaire
    # Obtenir les Utilisateurs
    function Get-UserNameAsArray {
        $users = Get-LocalUser | Select-Object -Property Name, Enabled
        return @($users)
    }
    <#
    .SYNOPSIS
    # Recherche un utiisateur passé en paramètre
    
    .DESCRIPTION
    Utilise la cmdlet Get-LocalUser pour vérifier si un utilisateur local existe sur la machine.
    
    .PARAMETER userName
    Un nom d'utilisateur à vérifier.
    
    .EXAMPLE
    PS C:\> Test-UserExists -userName "Jean"
    
    .NOTES
    General notes
    #>
    function Test-UserExists {
        param (
            [string]$userName           
        )
    
        $user = Get-LocalUser | Where-Object { $_.Name -eq $userName }
        if ($null -ne $user) {
            return $true
        }
        return $false
    }
    
    function Write-Log {
        [CmdletBinding()]
        [OutputType([void])] # Indique explicitement qu'il n'y a pas de sortie
        param([string]$Message)
    
        process {
            $logLine = "$(Get-Date): $Message"
            # On redirige la sortie vers $null ou on caste en [void] pour être sûr
            $logLine | Out-File -FilePath "C:\temp\log.txt" -Append
        }
    }

    function Remove-UserWithConfirm {
        [CmdletBinding()]
        param (
            
        )
        
        begin {
            
        }
        
        process {
            foreach ($user in $allUsers) {
                $confirm = Read-Host "Voulez-vous supprimer l'utilisateur $($user.Nom) ? (Oui/Non)"
                if ($confirm -eq "Oui") {
                    if (Test-UserExists -userName $user.Nom) {
                        try {
                            Write-Host "Suppression de l'utilisateur : $($user.Nom)..." -ForegroundColor Yellow
                            Remove-LocalUser -Name $user.Nom -Confirm:$true -ErrorAction Stop
                            Write-Log -Message "Utilisateur $($user.Nom) supprimé avec succès."
                        }
                        catch {
                            $err = "Erreur lors de la suppression de $($user.Nom) : $($_.Exception.Message)"
                            Write-Error $err
                            Write-Log -Message $err
                        }
                    }
                    else {
                        Write-Host "L'utilisateur $($user.Nom) n'existe pas, donc pas de suppression." -ForegroundColor Cyan
                    }
                }
            }   
        }
        
        end {
            
        }
    }

    function Add-UserFromCsv {
        [CmdletBinding()]
        param (
            
        )
        
        begin {
            
        }
        
        process {
            foreach ($user in $allUsers) {
                # Vérification si la colonne Nom existe bien dans le CSV
                if ([string]::IsNullOrWhiteSpace($user.Nom)) {
                    Write-Warning "Une ligne du CSV a un nom vide. Saut de la ligne."
                    continue
                }
        
                if (Test-UserExists -userName $user.Nom) {
                    Write-Host "L'utilisateur $($user.Nom) existe déjà." -ForegroundColor Cyan
                }
                else {
                    try {
                        Write-Host "Création de l'utilisateur : $($user.Nom)..." -ForegroundColor Yellow
                        
                        # Création de l'utilisateur
                        $params = @{
                            Name                = $user.Nom
                            FullName            = $user.Nom
                            Description         = "Utilisateur créé via script PowerShell"
                            AccountNeverExpires = $true
                            NoPassword          = $true # Optionnel : si vous ne mettez pas de mot de passe
                        }
                        New-LocalUser @params -ErrorAction Stop
                        
                        Write-Log -Message "Utilisateur $($user.Nom) créé avec succès."
        
                        # Ajout au groupe
                        if (-not [string]::IsNullOrWhiteSpace($user.Groupe)) {
                            Add-LocalGroupMember -Group $user.Groupe -Member $user.Nom -ErrorAction Stop
                            Write-Log -Message "Ajout de $($user.Nom) au groupe $($user.Groupe) réussi."
                        }
                    }
                    catch {
                        $err = "Erreur pour $($user.Nom) : $($_.Exception.Message)"
                        Write-Error $err
                        Write-Log -Message $err
                    }
                }
            }
        }
        
        end {
            
        }
    }
}



process {
    # Lecture
    

    Get-UserToAdd .\utilisateurs.csv
    $allUsers = Get-UserInCsv -csvPath "./utilisateurs.csv"
    # Création  

    Add-UserFromCsv 

    # Suppression
    
    Remove-UserWithConfirm
}

end {
    
}
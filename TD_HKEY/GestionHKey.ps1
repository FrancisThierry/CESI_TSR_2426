

begin {
    # import des fonctions
    . ./FonctionHkey.ps1

}

process {
    # test de la fonction
    $computerName = Get-ComputerNameWithHkey
    Write-Host "Le nom de l'ordinateur récupéré depuis le registre est : $computerName" -ForegroundColor Cyan
    # Ajouter une clé de registre
    $path = "HKCU:\Software"
    $KeyAuditSante = "AuditSante"
    $fullPath = Join-Path -Path $path -ChildPath $KeyAuditSante

    $DernierCheck = (Get-Date).ToString()
    $VersionScript = 1  # Utiliser un entier pour un DWORD


    try {
        # 1. Enregistre la date (String par défaut)
        Set-RegistryKey -Path $fullPath -ValueName "DernierCheck" -Value $DernierCheck
    
        # 2. Enregistre la version (Type Dword spécifié)
        Set-RegistryKey -Path $fullPath -ValueName "VersionScript" -Value $VersionScript -Type Dword

        # 3. Active le mode sombre (Type Dword spécifié)
        Set-ToggleDarkMode  








        
    }
    catch {
        Write-Error "Une erreur s'est produite lors de la configuration du registre : $($_.Exception.Message)"
    }



}

end {
        
}
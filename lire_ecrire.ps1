param (
    [Parameter(Mandatory=$true)] [string]$Path,
    [Parameter(Mandatory=$true)] [string]$Action,
    [string]$Contenu
)

begin {
    # TOUTES les fonctions doivent être ICI
    function Read-FromFile {
        param($FilePath)
        if (Test-Path $FilePath) { Get-Content $FilePath -Encoding UTF8 }
    }

    function Write-ToFile {
        param($FilePath, $Value, [switch]$Append)
        # ... (votre code actuel de la fonction) ...
        if ($Append) { Add-Content $FilePath $Value } else { Set-Content $FilePath $Value }
    }
}

process {
    # Le code principal reste ICI
    try {
        switch ($Action) {
            "lecture"  { Read-FromFile -FilePath $Path }
            "ecriture" { Write-ToFile -FilePath $Path -Value $Contenu }
            "ajout"    { Write-ToFile -FilePath $Path -Value $Contenu -Append }
        }
    }
    catch {
        Write-Error $_.Exception.Message
    }
}
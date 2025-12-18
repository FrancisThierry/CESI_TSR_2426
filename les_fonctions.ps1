function Add-Int {
    param (
        [int]$a,
        [int]$b
    )

    return $a + $b
}
$resultat = Add-Int -a 5 -b 10
Write-Host "Le résultat de l'addition est : $resultat"

function Add-Int-WithPipeline {
    [CmdletBinding()]
    param (
        # ValueFromPipeline permet d'accepter des nombres via le pipe |
        [Parameter(ValueFromPipeline = $true)]
        [int]$a,

        [Parameter()]
        [int]$b = 0
    )

    begin {
        # S'exécute une seule fois au lancement
        Write-Debug "Initialisation du compteur"
        $sommeTotale = 0
    }

    process {
        # S'exécute pour chaque élément envoyé dans le pipeline
        $sommeTotale += ($a + $b)
    }

    end {
        # Renvoie le résultat final une fois que tout est traité
        return $sommeTotale
    }
}

# Exemple d'utilisation avec le pipeline
$valeurs = 1..5
$resultat = $valeurs | Add-Int-WithPipeline -b 10
Write-Host "Le résultat de l'addition est : $resultat"
# Devrait afficher 65 ( (1+10) + (2+10) + (3+10) + (4+10) + (5+10) )

$valeurs = 1,2
$resultat = $valeurs | Add-Int-WithPipeline -b 10
Write-Host "Le résultat de l'addition est : $resultat"
# Devrait afficher 23 ( (1+10) + (2+10) )

## Procédure void
function Set-MyLog {
    [CmdletBinding()]
    [OutputType([void])] # Indique explicitement qu'il n'y a pas de sortie
    param([string]$Message)

    process {
        $logLine = "$(Get-Date): $Message"
        # On redirige la sortie vers $null ou on caste en [void] pour être sûr
        $logLine | Out-File -FilePath "C:\temp\log.txt" -Append
    }
}
Set-MyLog -Message "Ceci est un message de log."

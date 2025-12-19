function Get-Rss {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Url
    )
    
    begin {
        Write-Host "--- Début de la collecte : $Url ---" -ForegroundColor Yellow
    }
    
    process {
        try {
            $flux = Invoke-RestMethod -Uri $Url
            
            # On traite les 10 premiers articles
            # PowerShell accumule automatiquement les sorties dans une variable si on affecte le foreach
            $resultats = foreach ($article in ($flux | Select-Object -First 10)) {
                
                # 1. Extraction sécurisée du texte
                # Certains flux RSS n'utilisent pas .InnerText, on vérifie donc le contenu
                $texteBrut = if ($article.description.InnerText) { 
                    $article.description.InnerText 
                } else { 
                    $article.description 
                }
                
                # 2. Nettoyage des balises HTML
                $textePropre = $texteBrut -replace '<[^>]+>', ''
                
                # 3. Calcul du nombre de mots (sécurisé contre les valeurs nulles)
                $nbMots = 0
                if (-not [string]::IsNullOrWhiteSpace($textePropre)) {
                    $nbMots = ($textePropre.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)).Count
                }
                
                # 4. Création et émission de l'objet personnalisé
                [PSCustomObject]@{
                    Titre       = $article.title.InnerText
                    Date        = $article.pubDate
                    Description = $textePropre.Trim()
                    Mots        = $nbMots
                    Lien        = $article.link
                }
            }
            
            # On retourne le tableau final
            return $resultats
        }
        catch {
            Write-Error "Erreur lors du traitement du flux RSS : $($_.Exception.Message)"
        }
    }
    
    end {
        Write-Host "--- Collecte terminée ---" -ForegroundColor Green
    }
}
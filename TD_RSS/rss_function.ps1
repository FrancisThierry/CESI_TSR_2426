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
            # On stocke le résultat dans une variable pour pouvoir la retourner proprement
            $resultats = foreach ($article in ($flux | Select-Object -First 10)) {
                
                # 1. Extraction propre du texte (gestion du CDATA via InnerText)
                $texteBrut = $article.description.InnerText
                
                # 2. Nettoyage des balises HTML résiduelles
                $textePropre = $texteBrut -replace '<[^>]+>', ''
                
                # 3. Calcul du nombre de mots
                $nbMots = ($textePropre.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)).Count
                
                # 4. Création de l'objet personnalisé
                [PSCustomObject]@{
                    Titre       = $article.title
                    Date        = $article.pubDate
                    Description = $textePropre.Trim()
                    Mots        = $nbMots
                    Lien        = $article.link
                }
            }
            
            # On retourne l'ensemble des objets vers le pipeline
            return $resultats
        }
        catch {
            Write-Error "Erreur lors du traitement du flux RSS : $($_.Exception.Message)"
        }
    }
    
    end {
        Write-Host "--- Collecte terminée avec succès ---" -ForegroundColor Green
    }
}
function Get-Rss
 {
    [CmdletBinding()]
    param (
        [string]$Url
    )
    
    begin {
        Write-Host "Début du traitement du flux RSS depuis l'URL: $url"
        
    }
    
    process {
        $flux = Invoke-RestMethod -Uri $url
        
        try {
            # Pour voir les articles (souvent situés dans la propriété 'item')
            $flux | Select-Object title, pubDate, link | Out-GridView
        
        
            foreach ($article in $flux) {
                Write-Host "Titre: $($article.title)"
                Write-Host "Date de publication: $($article.pubDate)"
                Write-Host "Lien: $($article.link)"
                Write-Host "-----------------------------------"
            }   
        }
        catch {
            Write-Host "Une erreur s'est produite lors du traitement du flux RSS."
        }
    }
    
    end {
        Write-Host "Traitement du flux RSS terminé."
        
    }
}
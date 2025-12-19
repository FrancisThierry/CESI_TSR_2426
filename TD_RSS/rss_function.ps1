function Get-Rss
 {
    [CmdletBinding()]
    param (
        [string]$Url
    )
    
    begin {
        Write-Host "Début du traitement du flux RSS depuis l'URL: $url" ForegroundColor Yellow
        
    }
    
    process {
        $flux = Invoke-RestMethod -Uri $url
        
        try {
            # Pour voir les articles (souvent situés dans la propriété 'item')
            # $flux | Select-Object title, pubDate, link | Out-GridView
            $flux | Select-Object title, pubDate, link, description -First 10
        
        
            foreach ($article in $flux) {
                Write-Host "Titre: $($article.title)"
                Write-Host "Date de publication: $($article.pubDate)"
                Write-Host "DESCRIPTION : $($article.description.InnerText)"
                Write-Host "Lien: $($article.link)"
                Write-Host "-----------------------------------"
            }   
        }
        catch {
            Write-Host "Une erreur s'est produite lors du traitement du flux RSS."
        }
    }
    
    end {
        Write-Host "Traitement du flux RSS terminé." -ForegroundColor Green
        
    }
}